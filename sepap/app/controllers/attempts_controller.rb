# -*- encoding : utf-8 -*-
class AttemptsController < ApplicationController
	load_and_authorize_resource
  # GET /attempts
  # GET /attempts.xml
  def index
	@tab = "hist"
	@problemas = current_user.attempts.select('numero_problema').group(:numero_problema)
    @attempts = current_user.attempts
    
    

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @attempts }
    end
  end

  # GET /attempts/1
  # GET /attempts/1.xml
  def show
    @attempt = Attempt.find(params[:id])
    
	#Desplegar el error de compilación en caso de existir
    if @attempt.resultado.include? 'Error de compilación'
    	if FileTest.exist?("archivos/alumno/#{@attempt.user.matricula}/#{@attempt.numero_problema}/error")
			archivo = File.new("archivos/alumno/#{@attempt.user.matricula}/#{@attempt.numero_problema}/error", "r")

			@error = ""
	  		archivo.each {|line|
	  			#quita el path de donde esta guardado el archivo, esto para no mostrar informacion del servidor
	  			#linea = line.gsub("archivos/alumno/#{@attempt.user.matricula}/#{@attempt.numero_problema}/","")		
	  			#linea = line.gsub(/\/([a-z]|sepap|((a|l)[0-9]+)|[0-9]+)+/, "")
	  			linea = line.gsub(/\/home\/([a-z]|[0-9]|\/)+\/sepap\/archivos\/alumno\/#{@attempt.user.matricula}\/#{@attempt.numero_problema}\//, "")
	  			@error << linea
			}
			archivo.close
		end
    end
    
    if FileTest.exist?("#{@attempt.code}")
		source = File.new("#{@attempt.code}", "r")
		@codigo = ""
		source.each {|line|
			@codigo << line
		}
		source.close
	end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @attempt }
    end
  end

  # GET /attempts/new
  # GET /attempts/new.xml
  def new
    @attempt = Attempt.new
    @tab = "newA"
    @numero = params[:numero]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @attempt }
    end
  end

  # GET /attempts/1/edit
  def edit
    @attempt = Attempt.find(params[:id])
  end

  # POST /attempts
  # POST /attempts.xml
  def create
    @attempt = Attempt.new(params[:attempt])
    @attempt.user_id = current_user.id
    
	@attempt.problem = Problem.where(:numero => @attempt.numero_problema).first
	@attempt.lenguaje = params[:lenguaje]
    #Aqui genera un numero aleatorio para definir que entrada y salida usara
    num = 1 + rand(3)
    
    
    
    # =======================================================
    # Aqui compila el codigo fuente y produce un resultado
    #incluir un if para cambiar la extension .java cuando se implemente otro lenguaje
    
    #=====
    #desde qui corta
    #=====
    #@attempt.save 
    
    
    
    #=========================================================

    respond_to do |format|
      if @attempt.save
      	     
      	#Checa si el problema a resolver es de modulos
		if @attempt.problem.modulo?
			link = `cd archivos/alumno/#{@attempt.user.matricula}/#{@attempt.numero_problema}; ln -s #{@attempt.problem.solution}`
		end
     
      	#tiempo limite
      	tiempo = @attempt.problem.tiempo
      	
		#archivo con el codigo fuente del alumno
		archivo = @attempt.code
		#archivo = "archivos/alumno/#{@attempt.user.matricula}/#{@attempt.numero_problema}/Problema#{@attempt.numero_problema}.java"
		
		#archivo que se ejecutará despues de compilar
		ejecutable = "archivos/alumno/#{@attempt.user.matricula}/#{@attempt.numero_problema} Problema#{@attempt.numero_problema}"
		
		#entrada con la que se correrá el ejecutable
		entrada = "archivos/maestro/#{@attempt.numero_problema}/entrada#{num}"
		
		#archivo donde se guardará la salida al ejecutar el archivo del alumno
		salida = "archivos/alumno/#{@attempt.user.matricula}/#{@attempt.numero_problema}/salida"
		
		#salida esperada proporcionada por el profesor
		salida_esperada = "archivos/maestro/#{@attempt.numero_problema}/salida_esperada#{num}"
		
		#archivo donde se guardarán los errores de compilación, ejecucion, etc. en caso de existir
		error = "archivos/alumno/#{@attempt.user.matricula}/#{@attempt.numero_problema}/error"
		
		
		#se llama al compilador
		resultado = `./compilarJava2 #{archivo} '#{ejecutable}' #{entrada} #{salida} #{salida_esperada} #{error} #{tiempo}`
		
		if resultado.include? "ACEPTADO"
			resultado = "Aceptado"
			
			elsif resultado.include? "Error de compilación"
				resultado = "Error de compilación"
			
			elsif resultado.include? "Tiempo excedido"
				resultado = "Tiempo excedido"
			
			else 
				resultado = "Rechazado"

		end

		#en caso de producirse un error y no tener un resultado
		@attempt.update_attribute(:resultado, "#{resultado}")

		
        format.html { redirect_to(@attempt, :notice => 'El Intento fue creado exitosamente.') }
        format.xml  { render :xml => @attempt, :status => :created, :location => @attempt }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @attempt.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /attempts/1
  # PUT /attempts/1.xml
  def update
    @attempt = Attempt.find(params[:id])

    respond_to do |format|
      if @attempt.update_attributes(params[:attempt])
        format.html { redirect_to(@attempt, :notice => 'El Intento fue actualizado exitosamente.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @attempt.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /attempts/1
  # DELETE /attempts/1.xml
  def destroy
    @attempt = Attempt.find(params[:id])
    @attempt.destroy

    respond_to do |format|
      format.html { redirect_to(attempts_url) }
      format.xml  { head :ok }
    end
  end
end
