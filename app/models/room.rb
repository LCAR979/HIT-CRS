class Room < ActiveRecord::Base
	#has many or belong to ....
	attr_accessible :week, :location, :building, :size, 
	:day1course1, :day1course3, :day1course5, :day1course7, :day1course9, :day1course11, 
	:day2course1, :day2course3, :day2course5, :day2course7, :day2course9, :day2course11, 
	:day3course1, :day3course3, :day3course5, :day3course7, :day3course9, :day3course11, 
	:day4course1, :day4course3, :day4course5, :day4course7, :day4course9, :day4course11,
	:day5course1, :day5course3, :day5course5, :day5course7, :day5course9, :day5course11,
	:day6course1, :day6course3, :day6course5, :day6course7, :day6course9, :day6course11, 
	:day7course1, :day7course3, :day7course5, :day7course7, :day7course9, :day7course11
end