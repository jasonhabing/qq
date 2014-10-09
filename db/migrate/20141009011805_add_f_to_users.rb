class AddFToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :f, :boolean, :default => false
  end

  def self.down
    remove_column :users, :f
  end
end
