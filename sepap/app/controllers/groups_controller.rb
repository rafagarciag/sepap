# -*- encoding : utf-8 -*-
class GroupsController < ApplicationController
load_and_authorize_resource
  # GET /groups
  # GET /groups.xml
  def index
    @tab = "listaG"
    @groups = Group.where(:user_id => current_user.id).page(params[:page]).per(15)
    #Solamente los grupos del maestro logeado

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.xml
  def show
  	@tab = "listaG"
    @group = Group.find(params[:id])
    @miembros = User.where(:group_id => @group.id).order(:matricula).page(params[:page]).per(30)
    #regresa los miembros del grupo, ordenados por matricula

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @group }
    end
  end

  def show_consulta #cuando se despliegan todos los intentos de un alumno
#   @intentos = Attempt.where(:user_id => params[:user_id])
   @usuario = User.find(params[:user_id])
   @intentos = @usuario.attempts
   respond_to do |format|
      format.html
    end
  end

  #POST /grupos/1
  #cuando se utiliza el buscador por numero de problema
	def show_resumen 
		@group = Group.find(params[:group_id])
		@con_intento = []
		@sin_intento = []
		@por_matricula = []
		@numero = params[:num]

		if Problem.find_by_numero(@numero) #checa si existe el numero de problema
			miembros = @group.users.order(:matricula)	#Todos los miembros del grupo

			miembros.each do |m|
				#primero checa si el usuario ya tiene algun attempt de ese numero
				if m.attempts.find_by_numero_problema(@numero)

					intentos = m.attempts.select('attempts.*, count(attempts.id) as conteo').where(:numero_problema => @numero).group(:user_id)

					intentos.each do |i|
						@con_intento << i
						@por_matricula << i
					end
				else
					@sin_intento << m
					@por_matricula << m
			end
		end
	end

   respond_to do |format|
      format.html
    end
  end


  def show_codigo
   @usuario = User.find(params[:user_id])
   @problema = Problem.find(params[:problem_id])
   
   #se arregla el bug de mostrar codigo 
   nombre_archivo = @usuario.attempts.find_last_by_numero_problema(@problema.numero).code
   nombre_aceptado = "archivos/alumno/#{@usuario.matricula}/#{@problema.numero}/aceptado/aceptado"

   #Buscar el archivo (.java)
   #Checar si existe el .java en caso de que se haya borrado manualmente
   # o por un error

   if FileTest.exist?("#{nombre_archivo}")
	   archivo = File.new("#{nombre_archivo}", "r")
		@codigo = ""
		archivo.each {|line|
			@codigo << line
		}

		archivo.close
	end

	if FileTest.exist?("#{nombre_aceptado}")
		archivo = File.new("#{nombre_aceptado}", "r")
		@codigoaceptado = ""
		archivo.each {|line|
			@codigoaceptado << line
		}

		archivo.close
	end

   respond_to do |format|
      format.html
    end
  end

  # GET /groups/new
  # GET /groups/new.xml
  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  def agrega_alumno
      @group = Group.find(params[:group_id])
      matricula = (params[:matricula]).squeeze(" ").strip.downcase
      nombre = (params[:nombre]).squeeze(" ").strip
      apellidos = (params[:apellidos]).squeeze(" ").strip
      miembro = User.find_by_matricula("#{matricula}")
      puts "busco"
	    if miembro != nil
			miembro.group_id = @group.id
			puts "encontro"
		else
			miembro = User.new
			miembro.matricula = "#{matricula}"
			miembro.nombre = "#{nombre}"
			miembro.apellido = "#{apellidos}"
			miembro.email = "#{matricula}@itesm.mx"
			miembro.estudiante = true
			miembro.profesor = false
			miembro.admin = false
			miembro.password = "#{matricula}"
			miembro.password_confirmation = "#{matricula}"
			miembro.group_id = @group.id
		end
		if miembro.save
		    @exito = true;
		     respond_to do |format|
                format.html { redirect_to @group, :notice => "Se agregó el alumno al grupo."}
                format.xml { head :ok }
             end
        else
            respond_to do |format|
       		    @exito = false;
                format.html { redirect_to@group, :notice => "Error al agregar el alumno."}

                format.xml { head :ok }
            end
        end
  end

  # POST /groups
  # POST /groups.xml
  def create
    @group = Group.new(params[:group])
	@group.user_id = current_user.id
	@errores = Hash.new
	i = 1

#====================================
#Crear grupo de alumnos desde archivo
#====================================
#@group.save #esto para tener disponible el archivo
#if FileTest.exist?("public/#{@group.miembros}")
# @group.save


#end
#====================================
	respond_to do |format|
		if @group.save
			
			#Convertir saltos de linea de Windows/Mac a saltos de linea para Linux
			`mac2unix archivos/grupos/#{@group.clave}/miembros`
			`dos2unix archivos/grupos/#{@group.clave}/miembros`
			archivo = File.new("archivos/grupos/#{@group.clave}/miembros", "r")
			
			while (line = archivo.gets)
				arr = line.split(',')

				if arr.length == 3 #Verifica que sean tres elementos separados por coma "matricula, nombre, apellido(s)"
					matricula = arr[0].squeeze(" ").strip.downcase #Se eliminan espacios en blanco extra, ya sea al inicio, en medio, o al final del string y se hace minuscula la 'A'
					nombre = arr[1].squeeze(" ").strip
					apellidos = arr[2].squeeze(" ").strip

					#Si ya existe el alumno, solo se le asigna el grupo
					miembro = User.find_by_matricula("#{matricula}")
					if miembro != nil
						miembro.group_id = @group.id
						if !miembro.save
							@errores[i] = line
						end
					else
						miembro = User.new
						miembro.matricula = "#{matricula}"
						miembro.nombre = "#{nombre}"
						miembro.apellido = "#{apellidos}"
						miembro.email = "#{matricula}@itesm.mx"
						miembro.estudiante = true
						miembro.profesor = false
						miembro.admin = false
						miembro.password = "#{matricula}"
						miembro.password_confirmation = "#{matricula}"
						miembro.group_id = @group.id
						if !miembro.save
							@errores[i] = line
						end
					end
				else
					if !line.blank?
						@errores[i] = line
					end
				end

				#Va contando el número de linea
				i += 1

			end #Cierra while
			archivo.close
			@exito = true
		    format.html { redirect_to(group_path(:id => @group.id, :errores => @errores), :notice => 'El Grupo fue creado exitosamente') }
		    format.xml { render :xml => @group, :status => :created, :location => @group }
		else
			@exito = false
		    format.html { render :action => "new", :notice => 'Ha ocurrido un error al intentar crear el grupo' }
		    format.xml { render :xml => @group.errors, :status => :unprocessable_entity }
		end #Cierra if
    end #Cierra respond
  end #Cierra metodo

  #Da de baja a un alumno de un grupo, NO elimina al alumno de la base de datos
  def sacar
	usuario = User.find(params[:miembro])
	grupo = Group.find(params[:group_id])

	puts "///////////////////////////////////"
	puts usuario.nombre
	puts usuario.matricula
	puts usuario.group.clave
	puts usuario.group_id
	puts "//////////////////////////////////"

	usuario.group_id = nil
	if usuario.save
		    @exito = true;
		     respond_to do |format|
                format.html { redirect_to grupo, :notice => "Se dio de baja al alumno del grupo."}
                format.xml { head :ok }
             end
        else
            respond_to do |format|
       		    @exito = false;

                format.html { redirect_to grupo, :notice => "Ha ocurrido un error intentar dar de baja el alumno"}
                format.xml { head :ok }
            end
        end
  end

  # PUT /groups/1
  # PUT /groups/1.xml
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to(@group, :notice => 'El Grupo fue Actualizado exitosamente.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.xml
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to(groups_url) }
      format.xml { head :ok }
    end
  end
end
