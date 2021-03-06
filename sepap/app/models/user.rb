# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base

	#Control para que el acceso sea Case Insensitive
	before_save do
		self.email.downcase! if self.email
		self.matricula.downcase! if self.matricula
	end

	def self.find_for_authentication(conditions) 
		conditions[:matricula].downcase! 
		super(conditions) 
	end
	
	def codigo_aceptado?(numero)
		arr = []
		for attempt in self.attempts do
			if attempt.numero_problema==numero
				arr << attempt.resultado
			end
		end
		arr.include?('Aceptado')
	end


  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable, :recoverable
	devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable, :recoverable

	# Setup accessible (or protected) attributes for your model
	attr_accessible :email, :password, :password_confirmation, :remember_me, :nombre, :apellido, :matricula, :admin, :profesor, :group_id 
  
	#Relaciones con otras clases
	has_many :attempts,  :dependent => :delete_all	#Se eliminan los attempts si se elimina un alumno
	has_many :problems
	belongs_to :group

	#Validaciones para la forma
	validates_presence_of :email, :message => "El correo no puede estar en blanco"
	validates_presence_of :password, :on => :create,  :message => "La contraseña no puede estar en blanco"
	validates_presence_of :nombre, :message => "El nombre no puede estar en blanco"
	validates_presence_of :apellido, :message => "El apellido no puede estar en blanco"
	validates_presence_of :matricula, :message => "La matrícula no puede estar en blanco"
	validates_format_of :matricula, :with => /\A(A|L)([0-9]{8})\z/i, :message => "Favor de escribir la matrícula en el formato A00123456"
	
	#Esto se utiliza para que no acepte A00123456 y a00123456 como diferentes
	validates_uniqueness_of :matricula, :case_sensitive => false, :message => "Ya existe un usuario con la misma matrícula"
	#Valida longitud minima y maxima de nombre y apellido
	validates_length_of :nombre, :maximum => 40, :message => "El nombre no puede tener más de 40 caracteres"
	validates_length_of :apellido, :maximum => 50, :message => "El apellido no puede tener más de 50 caracteres"
	validates_length_of :nombre, :minimum => 2, :message => "El nombre debe tener mínimo dos caracteres"
	validates_length_of :apellido, :minimum => 2, :message => "El apellido tener mínimo dos caracteres"
	

end
