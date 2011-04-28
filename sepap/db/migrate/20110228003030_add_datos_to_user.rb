    class AddDatosToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :nombre, :string
    add_column :users, :apellido, :string
    add_column :users, :matricula, :string
    add_column :users, :admin, :boolean, :default => 0
    add_column :users, :profesor, :boolean, :default => 0
    add_column :users, :estudiante, :boolean, :default => 1
  end

  def self.down
    remove_column :users, :estudiante
    remove_column :users, :profesor
    remove_column :users, :admin
    remove_column :users, :matricula
    remove_column :users, :apellido
    remove_column :users, :nombre
  end
end
