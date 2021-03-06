class CreateApplicants < ActiveRecord::Migration
  def up
  	create_table 'applicants' do |t| 
   		t.string	:username  
   		t.string	:password		
   		t.string	:name
   		t.string 	:phone 	
   		t.string 	:email	
   		t.string 	:studentid
  		t.string 	:department	
  		t.integer :status,  :default => 0
                  # 0 not verified, 1 verified and normal , 2 closed
      t.string  :confirm_token
      t.string :remember_token
      t.string :image
      t.integer :cancel_num,  :default => 0  # cancelled numbers
      t.integer :unread
	  end 

    add_index :applicants, :email
    add_index :applicants, :confirm_token 
    add_index :applicants, :remember_token
  end 

  def down
  	drop_table 'applicants'
  end
end
