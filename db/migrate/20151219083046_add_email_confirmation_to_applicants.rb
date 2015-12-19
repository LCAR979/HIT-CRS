class AddEmailConfirmationToApplicants < ActiveRecord::Migration
  def change   	    
  	add_column :applicants, :email_confirmed, :boolean, :default => false     	
  	add_column :applicants, :confirm_token, :string  
  end
end
