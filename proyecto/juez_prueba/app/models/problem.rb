class Problem < ActiveRecord::Base
	belongs_to :user

	validates_presence_of :number, :message => "Falta especificar el número de problema"
	validates_presence_of :title, :message => "Falta especificar el título del problema"
	validates_presence_of :description, :message => "Falta redactar la especificación del problema"
	validates_uniqueness_of :number, :message => "El número está duplicado"
end
