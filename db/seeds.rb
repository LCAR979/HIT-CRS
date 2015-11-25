# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

arr = Room.new.attributes.keys - Room.protected_attributes.to_a
@attributes = arr[4..arr.length]

5.times do |i|
	Applicant.create(username: "st#{i}",password: "123456", studentid: "12345#{i}", phone: "1232132#{i}", department: "Dep#{i}",
		email: "123242142#{i}.qq.com", name: "CS#{i}",  isvalid: true)
	Staff.create(username: "staff#{i}",name: "xx#{i}",  staffid: "12345#{i}", phone: "1232132#{i}",
		email: "123242142#{i}.qq.com", password: "123456", isvalid: true)
	Room.create(week:i, location:"20#{i}",building:rand(0..1),size:rand(0..3),
		day1course1:rand(0..1), day1course3:rand(0..1), day1course5:rand(0..1),
		day1course7:rand(0..1), day1course9:rand(0..1), day1course11:rand(0..1),
		day2course1:rand(0..1), day2course3:rand(0..1), day2course5:rand(0..1),
		day2course7:rand(0..1), day2course9:rand(0..1), day2course11:rand(0..1), 
		day3course1:rand(0..1), day3course3:rand(0..1), day3course5:rand(0..1), 
		day3course7:rand(0..1), day3course9:rand(0..1), day3course11:rand(0..1),
		 day4course1:rand(0..1), day4course3:rand(0..1), day4course5:rand(0..1), 
		 day4course7:rand(0..1), day4course9:rand(0..1), day4course11:rand(0..1),
		  day5course1:rand(0..1), day5course3:rand(0..1), day5course5:rand(0..1), 
		  day5course7:rand(0..1), day5course9:rand(0..1), day5course11:rand(0..1), 
		  day6course1:rand(0..1), day6course3:rand(0..1), day6course5:rand(0..1), 
		  day6course7:rand(0..1), day6course9:rand(0..1), day6course11:rand(0..1), 
		  day7course1:rand(0..1), day7course3:rand(0..1), day7course5:rand(0..1), 
		  day7course7:rand(0..1), day7course9:rand(0..1), day7course11:rand(0..1))

end
