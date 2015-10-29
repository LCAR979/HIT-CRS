# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

5.times do |i|
	Applicant.create(username: "Name #{i}", studentid: "12345#{i}", phone: "1232132#{i}", department: "Dep#{i}",
		email: "123242142#{i}.qq.com", name: "CS#{i}", password: "sdsdsadsad#{i}", isvalid: true)
	#Staff.create(name: "Name #{i}", username: "xx#{i}", staffid: "12345#{i}", phone: "1232132#{i}",
	#	email: "123242142#{i}.qq.com", password: "sdsdsadsad#{i}", isvalid: true)
end
