class AddstaffsTasks < ActiveRecord::Migration
  def up
  	add_column :staffs, :tasks, :integer, :default => 0
  end

  def down
  	remove_column :staffs, :tasks, :integer
  end
end
