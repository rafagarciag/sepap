class AddOutput3ToProblems < ActiveRecord::Migration
  def self.up
    add_column :problems, :output3, :string
  end

  def self.down
    remove_column :problems, :output3
  end
end
