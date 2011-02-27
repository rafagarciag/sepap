class AddOutputToProblem < ActiveRecord::Migration
  def self.up
    add_column :problems, :output, :string
  end

  def self.down
    remove_column :problems, :output
  end
end
