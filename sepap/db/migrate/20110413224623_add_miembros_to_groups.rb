# -*- encoding : utf-8 -*-
class AddMiembrosToGroups < ActiveRecord::Migration
  def self.up
    add_column :groups, :miembros, :string
  end

  def self.down
    remove_column :groups, :miembros
  end
end
