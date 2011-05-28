class AddMetodoToProblems < ActiveRecord::Migration
  def self.up
    add_column :problems, :metodo, :string
  end

  def self.down
    remove_column :problems, :metodo
  end
end
