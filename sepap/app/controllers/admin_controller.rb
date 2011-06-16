class AdminController < ApplicationController
	def index
        @tab = "admin"
		#el index es estático, solo tiene links a las opciones
	end
  
	# Se despliega una lista con los usuarios con matricula 'L00123456'
	#	y que aun no tienen derechos de profesor
	def alta_profesores_lista
		@profesores = []
		@tab = "admin"
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
  
	# Se le dan derechos de profesor a un usuario
	def alta_profesores
		@tab = "admin"
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
	

	def eliminar_usuario_lista
		@tab = "admin"
		@usuarios = User.select('id, matricula, nombre, apellido').order(:matricula).page(params[:page]).per(5)
		
		#Se usa kaminari para paginación con el .page

	end
	
	# DELETE /admin/eliminar/1
	def eliminar_usuario
		@usuario = User.find(params[:id])
		@usuario.destroy
		
		respond_to do |format|
			format.html { redirect_to(eliminar_usuario_lista_path) }
			format.xml { head :ok }
		end
	end

end
