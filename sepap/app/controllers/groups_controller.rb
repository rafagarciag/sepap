# -*- encoding : utf-8 -*-
class GroupsController < ApplicationController
load_and_authorize_resource
  # GET /groups
  # GET /groups.xml
  def index
    @tab = "listaG" 
    @groups = Group.where(:user_id => current_user.id) #Solamente los grupos del maestro logeado
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.xml
  def show
    @group = Group.find(params[:id])
    @miembros = User.where(:group_id => @group.id).order(:matricula) #regresa los miembros del grupo, ordenados por matricula
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @group }
    end
  end
  
  def show_consulta #cuando se despliegan todos los intentos de un alumno
   @intentos = Attempt.where(:user_id => params[:user_id])
   @usuario = User.find(params[:user_id])
   respond_to do |format|
      format.html
    end
  end
  
  #POST /grupos/1
	def show_resumen #cuando se utiliza el buscador
		@group = Group.find(params[:group_id])
		if Problem.where(:numero => params[:num]) #checa si existe el numero de problema
			intentos = Attempt.select('attempts.*, count(attempts.id) as conteo').where(:numero_problema => params[:num]).group(:user_id)
			@con_intento = []
			intentos.each do |i|
			if i_grupo = i.user.group #checar priemro si el usuario pertenece a un grupo
				if i_grupo.id == @group.id #luego checa si es el grupo que buscamos
					@con_intento << i
				end
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
   nombre_archivo = "archivos/alumno/#{@usuario.matricula}/#{@problema.numero}/Problema#{@problema.numero}.java"
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
		puts "salio del if"
		if miembro.save
		puts "grabo"
		     respond_to do |format|
                format.html { redirect_to(@group, :message => "Se agregó el alumno al grupo")}
                format.xml { head :ok }
             end
        else
        puts "no grabo"
            respond_to do |format|
                format.html { redirect_to(@group, :message => "Error al agregar el alumno")}
                format.xml { head :ok }
            end
        end
  end

  # POST /groups
  # POST /groups.xml
  def create
    @group = Group.new(params[:group])
	@group.user_id = current_user.id

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
					miembro.save
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
					miembro.save
				end
			end
		end
		archivo.close

        format.html { redirect_to(@group, :notice => 'El Grupo fue creado exitosamente.') }
        format.xml { render :xml => @group, :status => :created, :location => @group }
	else
        format.html { render :action => "new" }
        format.xml { render :xml => @group.errors, :status => :unprocessable_entity }
	end
    end
  end
  
  #Da de baja a un alumno de un grupo, NO elimina al alumno de la base de datos
  def sacar
	usuario = User.find(params[:miembro])
	grupo = Group.find(params[:group_id])

	usuario.group_id = nil
	usuario.save

    respond_to do |format|
      format.html { redirect_to(grupo_path(:id => grupo.id))}
      format.xml { head :ok }
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
