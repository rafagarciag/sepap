class AddTiempoLimiteToProblems < ActiveRecord::Migration
  def self.up
    add_column :problems, :tiempo, :integer
  end

  def self.down
    remove_column :problems, :tiempo
  end
end
