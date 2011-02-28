class AddCodeToAttempts < ActiveRecord::Migration
  def self.up
    add_column :attempts, :code, :string
  end

  def self.down
    remove_column :attempts, :code
  end
end
