class AddOutput2ToProblems < ActiveRecord::Migration
  def self.up
    add_column :problems, :output2, :string
  end

  def self.down
    remove_column :problems, :output2
  end
end
