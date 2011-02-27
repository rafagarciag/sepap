class Problem < ActiveRecord::Base
	belongs_to :user

	attr_accessible :number, :title, :description, :code, :input, :output

	validates_presence_of :number, :message => "Falta especificar el número de problema"
	validates_presence_of :title, :message => "Falta especificar el título del problema"
	validates_presence_of :description, :message => "Falta redactar la especificación del problema"
	validates_uniqueness_of :number, :message => "El número está duplicado"
	validates_presence_of :code
	validates_presence_of :input
	validates_presence_of :output

	mount_uploader :code, CodeUploader
	mount_uploader :input, InputUploader
	mount_uploader :output, OutputUploader
	
end
