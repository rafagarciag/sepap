class Problem < ActiveRecord::Base

	attr_accessible :numero, :titulo, :descripcion, :solution, :input, :output, :id
	
	#Relaciones con otras clases
	has_many :attempts
	belongs_to :user

	#Validaciones para la forma
	validates_presence_of :numero, :message => "Falta especificar el número de problema"
	validates_presence_of :titulo, :message => "Falta especificar el título del problema"
	validates_presence_of :descripcion, :message => "Falta redactar la especificación del problema"
	validates_uniqueness_of :numero, :message => "El número está duplicado"
	validates_presence_of :solution
	validates_presence_of :input
	validates_presence_of :output
	
	#Esto utiliza la gema carrierwave
	mount_uploader :solution, SolutionUploader
	mount_uploader :input, InputUploader
	mount_uploader :output, OutputUploader
	

end
