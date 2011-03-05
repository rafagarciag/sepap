class Attempt < ActiveRecord::Base
	attr_accessible :code, :numero_problema, :resultado, :numero_de_intentos
	
	#Relaciones con otras clases
	belongs_to :user
	belongs_to :problem
	
	#Validaciones para la forma
	validates_presence_of :code, :message => "Es necesario adjuntar un archivo con su código"
	validates_presence_of :problem_id, :message => "El número de problema no existe"
	validates_numericality_of :numero_problema

	#esto utiliza la gema carrierwave 
	mount_uploader :code, CodeUploader
end
