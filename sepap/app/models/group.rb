# -*- encoding : utf-8 -*-
class Group < ActiveRecord::Base
    attr_accessible :miembros, :clave, :nombre, :campus, :semestre, :fecha, :user_id, :id

	#Relaciones con otras clases  
	belongs_to :user
	has_many :users
	
	#Validaciones para la forma
	validates_presence_of :clave, :message => "Falta especificar la clave del grupo"
	validates_presence_of :nombre, :message => "Falta especificar el nombre del grupo"
	#validates_presence_of :campus, :message => "Falta especificar el campus del grupo"
	#validates_presence_of :semestre, :message => "Falta especificar el semestre del grupo"
	#validates_presence_of :fecha, :message => "Falta especificar la fecha del grupo"
	#validates_presence_of :miembros, :message => "Falta especificar el archivo con los miembros del grupo"
	validates_presence_of :miembros, :on=>:create, :message => "Falta archivo con miembros"
	
	validates_uniqueness_of :clave, :case_sensitive => false, :message => "Ya existe un grupo con la misma clave"
	
	#Usado por la gema CarrierWave para subir el archivo con los miembros del grupo
	mount_uploader :miembros, MiembrosUploader
end
