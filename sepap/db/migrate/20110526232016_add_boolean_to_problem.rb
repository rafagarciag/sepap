class AddBooleanToProblem < ActiveRecord::Migration
  def self.up
    add_column :problems, :modulo, :boolean
  end

  def self.down
    remove_column :problems, :modulo
  end
end
