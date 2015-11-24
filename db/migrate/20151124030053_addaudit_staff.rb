class AddauditStaff < ActiveRecord::Migration
  def change
  	add_column :requests, :auditStaffname, :string
  end

  def down
  	remove_column :requests, :auditStaffname, :string
  end
end
