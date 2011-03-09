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
	validates_format_of :matricula, :with => /[Aa][0-9]{8}/i, :message => "Favor de escribir la matrícula en el formato A00123456"
	validates_uniqueness_of :matricula, :message => "Ya existe un usuario con la misma matrícula"

end
