class AddCodeToProblem < ActiveRecord::Migration
  def self.up
    add_column :problems, :code, :string
  end

  def self.down
    remove_column :problems, :code
  end
end
