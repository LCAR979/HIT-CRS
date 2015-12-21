class CreateStaffs < ActiveRecord::Migration
  def up
  	create_table 'staffs' do |t|		
  		t.string :username
  		t.string :password
      t.string :name
      t.string :phone
      t.string :email 
      t.string :staffid
  		t.integer :status,  :default => 0  
                # 0 not verified, 1 verified and normal , 2 shut down
      t.string :confirm_token
      t.integer :tasks, :default => 0
      t.string :image
  	end
  end

  def down
  	drop_table 'staffs'
  end
end
