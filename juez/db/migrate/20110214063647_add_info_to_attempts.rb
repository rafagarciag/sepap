class AddInfoToAttempts < ActiveRecord::Migration
  def self.up
    add_column :attempts, :problemNo, :int
  end

  def self.down
    remove_column :attempts, :problemNo
  end
end
