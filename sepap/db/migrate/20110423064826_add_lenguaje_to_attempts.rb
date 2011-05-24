# -*- encoding : utf-8 -*-
class AddLenguajeToAttempts < ActiveRecord::Migration
  def self.up
    add_column :attempts, :lenguaje, :string
  end

  def self.down
    remove_column :attempts, :lenguaje
  end
end
