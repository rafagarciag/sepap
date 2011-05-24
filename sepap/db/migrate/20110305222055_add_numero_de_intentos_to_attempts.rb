# -*- encoding : utf-8 -*-
class AddNumeroDeIntentosToAttempts < ActiveRecord::Migration
  def self.up
    add_column :attempts, :numero_de_intentos, :integer
  end

  def self.down
    remove_column :attempts, :numero_de_intentos
  end
end
