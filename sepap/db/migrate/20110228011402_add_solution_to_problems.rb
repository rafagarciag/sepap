class AddSolutionToProblems < ActiveRecord::Migration
  def self.up
    add_column :problems, :solution, :string
  end

  def self.down
    remove_column :problems, :solution
  end
end
