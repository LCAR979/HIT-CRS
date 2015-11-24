class NewCreateApplicants < ActiveRecord::Migration
  def up
  	create_table 'applicants' do |t| 
 		t.string	:username  		
 		t.string 	:studentid		
 		t.string 	:phone 		
		t.string 	:department
		t.string 	:email
		t.string	:name
		t.string	:password	
		t.boolean 	:isvalid
	end  
  end

  def down
  	drop_table 'applicants'
  end
end
