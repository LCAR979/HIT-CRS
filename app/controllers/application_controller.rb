class ApplicationController < ActionController::Base
  protect_from_forgery
  #session for current user 
  protected
  def current_user
  	if (session[:applicant_id])
  		@current_user = Applicant.find(session[:applicant_id])
  	elsif (session[:staff_id])
  		@current_user = Staff.find(session[:staff_id])
  	else 
  		@current_user = nil
  	end
  end
end
