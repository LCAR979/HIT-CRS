class CreateRooms < ActiveRecord::Migration
  def up
  	create_table "rooms" do |t|	
  		t.string 	:location		#room location: different building, differet format
  		t.integer   :building 		#building inter[0-?] current: 0=>Zhengxin Building, 1=>GeWu Building, 
  		t.integer 	:size		 	#size is [0~3], 0=>42, 1=>72, 2=>120, 3=>260

  		# the following are room time using status column: 7*12 = 84 interval(we save 42)
  		# 0=> 'free', 1=>'class', 2=>'wait', 3=>'reserved'
  		t.integer   :week	 		#week is between 1~18
  		t.integer :day1course1      
		t.integer :day1course3
		t.integer :day1course5
		t.integer :day1course7
		t.integer :day1course9
		t.integer :day1course11
		t.integer :day2course1
		t.integer :day2course3
		t.integer :day2course5
		t.integer :day2course7
		t.integer :day2course9
		t.integer :day2course11
		t.integer :day3course1
		t.integer :day3course3
		t.integer :day3course5
		t.integer :day3course7
		t.integer :day3course9
		t.integer :day3course11
		t.integer :day4course1
		t.integer :day4course3
		t.integer :day4course5
		t.integer :day4course7
		t.integer :day4course9
		t.integer :day4course11
		t.integer :day5course1
		t.integer :day5course3
		t.integer :day5course5
		t.integer :day5course7
		t.integer :day5course9
		t.integer :day5course11
		t.integer :day6course1
		t.integer :day6course3
		t.integer :day6course5
		t.integer :day6course7
		t.integer :day6course9
		t.integer :day6course11
		t.integer :day7course1
		t.integer :day7course3
		t.integer :day7course5
		t.integer :day7course7
		t.integer :day7course9
		t.integer :day7course11
  	end 
  end

  def down
  	drop_table "rooms"
  end
end
