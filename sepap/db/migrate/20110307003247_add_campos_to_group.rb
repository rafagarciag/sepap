# -*- encoding : utf-8 -*-
class AddCamposToGroup < ActiveRecord::Migration
  def self.up
    add_column :groups, :campus, :string
    add_column :groups, :semestre, :int
    add_column :groups, :fecha, :date
  end

  def self.down
    remove_column :groups, :fecha
    remove_column :groups, :semestre
    remove_column :groups, :campus
  end
end
