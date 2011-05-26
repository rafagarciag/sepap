#Crea 10 estudiantes, 
#10 en el grupo 0 que le pertenece al maestro L12121200 
for i in 0..9
	puts "User.create(:email => \"A#{12121200+i}@itesm.mx\", :password => \"A#{12121200+i}\", :nombre => \"Nom#{i}\", :apellido => \"Ap#{i}\", :matricula => \"A#{12121200+i}\", :admin => false, :profesor => false, :estudiante => true, :group_id => 0)"
end
#10 en el grupo 1 que le pertenece al maestro L12121201
for i in 10..20
	puts "User.create(:email => \"A#{12121200+i}@itesm.mx\", :password => \"A#{12121200+i}\", :nombre => \"Nom#{i}\", :apellido => \"Ap#{i}\", :matricula => \"A#{12121200+i}\", :admin => false, :profesor => false, :estudiante => true, :group_id => 1)"
end
#Crea 2 maestros
#maestro L12121200 dueño del grupo 0
#maestro L12121201 dueño del grupo 1
for i in 0..1
	puts "User.create(:email => \"L#{12121200+i}@itesm.mx\", :password => \"L#{12121200+i}\", :nombre => \"Nom#{i}\", :apellido => \"Ap#{i}\", :matricula => \"L#{12121200+i}\", :admin => false, :profesor => true, :estudiante => false, :group_id => \"\")"
end
#Crea Administrador
puts "User.create(:email => \"L12121300@itesm.mx\", :password => \"L12121300\", :nombre => \"Nom0\", :apellido => \"Ap0\", :matricula => \"L12121300\", :admin => true, :profesor => false, :estudiante => false, :group_id => \"\")"
#Crea Administrador/Profesor
puts "User.create(:email => \"L12121301@itesm.mx\", :password => \"L12121301\", :nombre => \"Nom1\", :apellido => \"Ap1\", :matricula => \"L12121300\", :admin => true, :profesor => true, :estudiante => false, :group_id => \"\")"
#Crea archivo para grupo 0
