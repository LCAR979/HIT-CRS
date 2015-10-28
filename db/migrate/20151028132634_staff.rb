class Staff < ActiveRecord::Migration
  def up
  	create_table 'staffs' do |t|
  		t.string :name, null: false
  		t.string :staffid, null:false
  		t.string :phone, null: false
  		t.string :email, null: false
  		t.string :username, null: false
  		t.string :password, null: false
  		t.boolean :isvalid, null: false
  	end
  end

  def down
  	drop_table 'staffs'
  end
end
