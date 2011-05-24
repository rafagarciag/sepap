# -*- encoding : utf-8 -*-
class RemoveNumeroDeIntentosFromAttempts < ActiveRecord::Migration
  def self.up
    remove_column :attempts, :numero_de_intentos
  end

  def self.down
    add_column :attempts, :numero_de_intentos, :integer
  end
end
