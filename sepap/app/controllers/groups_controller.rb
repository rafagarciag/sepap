class GroupsController < ApplicationController
  # GET /groups
  # GET /groups.xml
  def index
    
    @groups = Group.where(:user_id => current_user.id)	#Solamente los grupos del maestro logeado
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.xml
  def show
    @group = Group.find(params[:id])
    @miembros = User.where(:group_id => @group.id).order(:matricula)	#regresa los miembros del grupo, ordenados por matricula
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @group }
    end
  end
  
  def show_consulta		#cuando se despliegan todos los intentos de un alumno
  	@intentos = Attempt.where(:user_id => params[:user_id])
  	@usuario = User.find(params[:user_id])
  	respond_to do |format|
      format.html
    end
  end
  
  #POST /grupos/1
  def show_resumen		#cuando se utiliza el buscador
  	@group = Group.find(params[:group_id])
  	@intentos = Attempt.select('attempts.*, count(attempts.id) as conteo').where(:numero_problema => params[:num]).group(:user_id) 	#Alumnos que ya tienen almenos un intento del problema especificado
  	@sin_intentar = User.where(:group_id => @group.id)	#alumnos que aun no tienen intentos, se desplegaran al final de la lista

  	respond_to do |format|
      format.html
    end
  end
  
  def show_codigo
  	@usuario = User.find(params[:user_id])
  	@problema = Problem.find(params[:problem_id])
  	
  	#Buscar el archivo (.java)
  	archivo = File.new("archivos/alumno/#{@usuario.matricula}/#{@problema.numero}/Problema#{@problema.numero}.java", "r")
  	@codigo = ""
  	archivo.each {|line|
  		@codigo << line
	}
  	respond_to do |format|
      format.html
    end
    
    archivo.close
  end

  # GET /groups/new
  # GET /groups/new.xml
  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  # POST /groups
  # POST /groups.xml
  def create
    @group = Group.new(params[:group])
	@group.user_id = current_user.id
	
	#====================================
	#Crear grupo de alumnos desde archivo
	#====================================
	@group.save		#esto para tener disponible el archivo
	archivo = File.new("archivos/grupos/#{@group.clave}/miembros", "r")
	while (line = archivo.gets)
		arr = line.split(',')
		matricula = arr[0].squeeze(" ").strip		#Se eliminan espacios en blanco extra, ya sea al inicio, en medio, o al final del string
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
			miembro.password = "#{matricula}"
			miembro.password_confirmation = "#{matricula}"
			miembro.group_id = @group.id
			miembro.save
		end
		
	end
	archivo.close
	
	#====================================
    respond_to do |format|
      if @group.save
        format.html { redirect_to(@group, :notice => 'El Grupo fue creado exitosamente.') }
        format.xml  { render :xml => @group, :status => :created, :location => @group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
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
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
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
      format.xml  { head :ok }
    end
  end
end
