# -*- encoding : utf-8 -*-
class CreateAttempts < ActiveRecord::Migration
  def self.up
    create_table :attempts do |t|
      t.integer :numero_problema
      t.string :resultado
      t.references :user
      t.references :problem

      t.timestamps
    end
  end

  def self.down
    drop_table :attempts
  end
end
