class AdminController < ApplicationController
	def index
		#el index es estático, solo tiene links a las opciones
	end
  
	def alta_profesores_lista
		@profesores = []
		usuarios = User.select('id, matricula, nombre, apellido, admin, profesor')
		usuarios.each do |usuario|
			if (usuario.matricula[0].chr == "l") || (usuario.matricula[0].chr == "L")
			#se checa primero que la matricula empiece con 'l'
			#'chr' se utiliza para lees el caracter tomando el ASCII
				if (!usuario.admin? && !usuario.profesor?)
				#checar que no sea admin ni profesor aun
					@profesores << usuario
				end
			end
		end
	end
  
	def alta_profesores
	  	prof = params[:miembro]
	  	
	  		x = User.find(prof)
	  		x.profesor = true	#se le dan derechos de profesor
	  		x.admin = false
	  		x.estudiante = false
	  		x.save

	  	
	  	respond_to do |format|
		  format.html { redirect_to(alta_profesores_lista_path)}
		  format.xml { head :ok }
		end
	end

end
