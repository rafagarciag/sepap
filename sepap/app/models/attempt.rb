# -*- encoding : utf-8 -*-
require 'file_size_validator'

class Attempt < ActiveRecord::Base
	attr_accessible :code, :numero_problema, :resultado, :lenguaje, :envio
	attr_accessor :envio
	
	#Relaciones con otras clases
	belongs_to :user
	belongs_to :problem
	
	#Validaciones para la forma
	validates_presence_of :code, :message => "Es necesario adjuntar un archivo con su código", :unless=>:ignore_validation
	validates_presence_of :problem_id, :message => "El número de problema no existe"
	validates_numericality_of :numero_problema, :message => "El número de problema debe contener solamente números"

	#esto utiliza la gema carrierwave 
	mount_uploader :code, CodeUploader
	validates :code,    :file_size => { :maximum => 0.1.megabytes.to_i }

	def ignore_validation
		if self.envio == "pegar"
			true
		else
			false
		end
	end
end

