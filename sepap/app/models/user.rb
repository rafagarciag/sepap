class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable, :recoverable
	devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable

	# Setup accessible (or protected) attributes for your model
	attr_accessible :email, :password, :password_confirmation, :remember_me, :nombre, :apellido, :matricula
  
	#Relaciones con otras clases
	has_many :problems

	#Validaciones para la forma
	validates_presence_of :nombre, :message => "El nombre no puede estar en blanco"
	validates_presence_of :apellido, :message => "El apellido no puede estar en blanco"
	validates_presence_of :matricula, :message => "La matrícula no puede estar en blanco"


end
