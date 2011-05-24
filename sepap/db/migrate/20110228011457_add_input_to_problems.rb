# -*- encoding : utf-8 -*-
class AddInputToProblems < ActiveRecord::Migration
  def self.up
    add_column :problems, :input, :string
  end

  def self.down
    remove_column :problems, :input
  end
end
