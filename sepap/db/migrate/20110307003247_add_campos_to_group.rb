class AddCamposToGroup < ActiveRecord::Migration
  def self.up
    add_column :groups, :campus, :string
    add_column :groups, :semestre, :int
    add_column :groups, :ano, :int
    add_column :groups, :mes, :string
  end

  def self.down
    remove_column :groups, :mes
    remove_column :groups, :ano
    remove_column :groups, :semestre
    remove_column :groups, :campus
  end
end
