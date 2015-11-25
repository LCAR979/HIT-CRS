class Applicant < ActiveRecord::Migration
  def up
  	create_table :applicants do |t| 
 		t.string	:username, null: false  		
 		t.string 	:studentid, null: false  		
 		t.string 	:phone, null: false  		
		t.string 	:department, null: false  		
		t.string 	:email, null: false  		
		t.string	:name, null:false  		
		t.string	:password, null:false  		
		t.boolean 	:isvalid, null:false  	
	end  
  end

  def down
  	drop_table :applicants
  end
end
