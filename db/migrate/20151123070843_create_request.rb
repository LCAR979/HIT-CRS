class CreateRequest < ActiveRecord::Migration
  def up
  	create_table 'requests' do |t|
  		t.string	:name			#student name
  		t.string 	:department		#department name 
  		t.string 	:location		#room location: different building, differet format
  		t.string 	:studentid		#student id number 
  		t.string 	:phone			#phone number 
  		t.string 	:description	#description for use
  		t.integer 	:numAttendents	#number of Attendents
  		t.integer   :building 		#build inter[1-?] current: 1=>zhengxin, 2=>GeWu
  		t.integer 	:size		 	#size is [1~4], 1=>42, 2=>72, 3=>120, 4=>260
  		t.boolean	:media	 		#media = 1, use multi-media
  		t.integer   :week	 		#week is between 1~18
  		t.integer   :time			#time is odd: time~time+1 interval[1~11]
  		t.integer   :status   		#status = 1 Permit 
  		t.string	:comment 		#comment feedback
  		t.string    :teachername	#corrresponding teacher 
  		t.string 	:teacherphone	#corrresponding teacher phone
  	end
  end
  def down
  	drop_table 'requests'
  end
end
