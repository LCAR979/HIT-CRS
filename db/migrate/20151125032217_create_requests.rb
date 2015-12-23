class CreateRequests < ActiveRecord::Migration
  def up
  	create_table 'requests' do |t|	
  		t.integer   :week	 		#week is between 1~18
      t.integer   :day      #[1~7]
  		t.integer   :time			#time is odd: time~time+1 interval[1~11]
      t.integer   :building     #build inter[1-?] current: 1=>zhengxin, 2=>GeWu
      t.string    :location   #room location: different building, differet format
      t.integer   :size     #size is [0-3], 0=>42, 1=>72, 2=>120, 3=>260
      t.boolean   :media      #media = 1, use multi-media
      t.text    :description  #description for use

  		t.integer   :status   		#status: 0=>permitted, 1=> rejected, 2=>wait,3=>cancelled		
      #response from teachers 
  		t.text	  :comment 		#comment feedback

  	  #foreigh key association
  		t.belongs_to :applicant
  		t.belongs_to :staff
      
  	end
  end
  def down
  	drop_table 'requests'
  end
end
