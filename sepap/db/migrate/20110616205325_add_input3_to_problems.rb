class AddInput3ToProblems < ActiveRecord::Migration
  def self.up
    add_column :problems, :input3, :string
  end

  def self.down
    remove_column :problems, :input3
  end
end
