# -*- encoding : utf-8 -*-
class Problem < ActiveRecord::Base

	attr_accessible :numero, :titulo, :descripcion, :solution, :input, :input2, :input3, :output, :output2, :output3, :id, :tiempo, :modulo
	
	#Relaciones con otras clases
	has_many :attempts
	belongs_to :user

	#Validaciones para la forma
	validates_presence_of :numero, :message => "Falta especificar el número de problema"
	validates_presence_of :titulo, :message => "Falta especificar el título del problema"
	validates_presence_of :descripcion, :message => "Falta redactar la especificación del problema"
	validates_presence_of :tiempo, :message => "Falta especificar el tiempo límite"
	validates_uniqueness_of :numero, :message => "El número está duplicado"
	validates_numericality_of :numero, :message => "El número de problema debe contener solamente números"
	validates_numericality_of :tiempo, :message => "El tiempo límite debe contener solamente números"

	validates_presence_of :solution, :on=>:create, :message => "Falta archivo de solución"

	validates_presence_of :input, :on=>:create, :message => "Falta archivo 'Entradas 1'"
	validates_presence_of :input2, :on=>:create, :message => "Falta archivo 'Entradas 2'"
	validates_presence_of :input3, :on=>:create, :message => "Falta archivo 'Entradas 3'"
	validates_presence_of :output, :on=>:create, :message => "Falta archivo 'Salidas 1'"
	validates_presence_of :output2, :on=>:create, :message => "Falta archivo 'Salidas 2'"
	validates_presence_of :output3, :on=>:create, :message => "Falta archivo 'Salidas 3'"
	validates_inclusion_of :modulo, :message => "Falta especificar tipo de problema (completo o módulo)", :in => [true, false]

	
	#Esto utiliza la gema carrierwave
	mount_uploader :solution, SolutionUploader
	
	mount_uploader :input, InputUploader
	mount_uploader :input2, Input2Uploader
	mount_uploader :input3, Input3Uploader

	mount_uploader :output, OutputUploader
	mount_uploader :output2, Output2Uploader
	mount_uploader :output3, Output3Uploader
	

end
