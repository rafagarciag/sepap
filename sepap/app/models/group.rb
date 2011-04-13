class Group < ActiveRecord::Base
    attr_accessible :miembros, :clave, :nombre, :campus, :semestre, :ano, :mes, :user_id

	#Relaciones con otras clases  
	belongs_to :user
	
	#Usado por la gema CarrierWave para subir el archivo con los miembros del grupo
	mount_uploader :miembros, MiembrosUploader
end
