class AddInput2ToProblems < ActiveRecord::Migration
  def self.up
    add_column :problems, :input2, :string
  end

  def self.down
    remove_column :problems, :input2
  end
end
