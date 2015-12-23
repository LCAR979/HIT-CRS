desc "This task is called by the Heroku scheduler add-on"
task :clean_bonus => :environment do
  current_time = Time.now
  if current_time.day == 1
	  puts "Cleaning bonus..."
	  @applicant_list = Applicant.all
	  @applicant_list.each do |t|
	  	t.update_attributes(cancel_num=>0)
	  end 
	  puts "done."
  end
end

task :send_reminders => :environment do
  User.send_reminders
end