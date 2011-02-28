class Problem < ActiveRecord::Base

	belongs_to :user

	attr_accessible :numero, :titulo, :descripcion, :solution, :input, :output

	validates_presence_of :numero, :message => "Falta especificar el número de problema"
	validates_presence_of :titulo, :message => "Falta especificar el título del problema"
	validates_presence_of :descripcion, :message => "Falta redactar la especificación del problema"
	validates_uniqueness_of :numero, :message => "El número está duplicado"
	validates_presence_of :solution
	validates_presence_of :input
	validates_presence_of :output

	mount_uploader :solution, SolutionUploader
	mount_uploader :input, InputUploader
	mount_uploader :output, OutputUploader
end
