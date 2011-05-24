# -*- encoding : utf-8 -*-
class ChangeDataTypeForGroupsSemestre < ActiveRecord::Migration
  def self.up
  	change_table :groups do |t|
	t.change :semestre, :string end
  end

  def self.down
  	change_table :groups do |t|
	t.change :semestre, :int end
  end
end
