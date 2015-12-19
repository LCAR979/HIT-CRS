# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20151219083046) do

  create_table "applicants", :force => true do |t|
    t.string  "username"
    t.string  "studentid"
    t.string  "phone"
    t.string  "department"
    t.string  "email"
    t.string  "name"
    t.string  "password"
    t.boolean "isvalid"
    t.boolean "email_confirmed", :default => false
    t.string  "confirm_token"
  end

  create_table "requests", :force => true do |t|
    t.string  "name"
    t.string  "department"
    t.string  "location"
    t.string  "studentid"
    t.string  "phone"
    t.string  "description"
    t.integer "numAttendents"
    t.integer "building"
    t.integer "size"
    t.boolean "media"
    t.integer "week"
    t.integer "time"
    t.integer "status"
    t.integer "day"
    t.string  "comment"
    t.string  "teachername"
    t.string  "teacherphone"
    t.integer "applicant_id"
    t.integer "staff_id"
  end

  create_table "rooms", :force => true do |t|
    t.integer "week"
    t.string  "location"
    t.integer "building"
    t.integer "size"
    t.integer "day1course1"
    t.integer "day1course3"
    t.integer "day1course5"
    t.integer "day1course7"
    t.integer "day1course9"
    t.integer "day1course11"
    t.integer "day2course1"
    t.integer "day2course3"
    t.integer "day2course5"
    t.integer "day2course7"
    t.integer "day2course9"
    t.integer "day2course11"
    t.integer "day3course1"
    t.integer "day3course3"
    t.integer "day3course5"
    t.integer "day3course7"
    t.integer "day3course9"
    t.integer "day3course11"
    t.integer "day4course1"
    t.integer "day4course3"
    t.integer "day4course5"
    t.integer "day4course7"
    t.integer "day4course9"
    t.integer "day4course11"
    t.integer "day5course1"
    t.integer "day5course3"
    t.integer "day5course5"
    t.integer "day5course7"
    t.integer "day5course9"
    t.integer "day5course11"
    t.integer "day6course1"
    t.integer "day6course3"
    t.integer "day6course5"
    t.integer "day6course7"
    t.integer "day6course9"
    t.integer "day6course11"
    t.integer "day7course1"
    t.integer "day7course3"
    t.integer "day7course5"
    t.integer "day7course7"
    t.integer "day7course9"
    t.integer "day7course11"
  end

  create_table "staffs", :force => true do |t|
    t.string  "name",                    :null => false
    t.string  "staffid",                 :null => false
    t.string  "phone",                   :null => false
    t.string  "email",                   :null => false
    t.string  "username",                :null => false
    t.string  "password",                :null => false
    t.boolean "isvalid",                 :null => false
    t.integer "tasks",    :default => 0
  end

end
