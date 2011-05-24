# -*- encoding : utf-8 -*-
class CreateProblems < ActiveRecord::Migration
  def self.up
    create_table :problems do |t|
      t.integer :numero
      t.string :titulo
      t.text :descripcion
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :problems
  end
end
