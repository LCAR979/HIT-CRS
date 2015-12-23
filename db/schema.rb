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

ActiveRecord::Schema.define(:version => 20151125032217) do

  create_table "applicants", :force => true do |t|
    t.string  "username"
    t.string  "password"
    t.string  "name"
    t.string  "phone"
    t.string  "email"
    t.string  "studentid"
    t.string  "department"
    t.integer "status",         :default => 0
    t.string  "confirm_token"
    t.string  "remember_token"
    t.string  "image"
    t.integer "cancel_num",     :default => 0
    t.integer "unread"
  end

  add_index "applicants", ["confirm_token"], :name => "index_applicants_on_confirm_token"
  add_index "applicants", ["email"], :name => "index_applicants_on_email"
  add_index "applicants", ["remember_token"], :name => "index_applicants_on_remember_token"

  create_table "requests", :force => true do |t|
    t.integer "week"
    t.integer "day"
    t.integer "time"
    t.integer "building"
    t.string  "location"
    t.integer "size"
    t.boolean "media"
    t.text    "description"
    t.integer "status"
    t.text    "comment"
    t.integer "applicant_id"
    t.integer "staff_id"
  end

  create_table "rooms", :force => true do |t|
    t.string  "location"
    t.integer "building"
    t.integer "size"
    t.integer "week"
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
    t.string  "username"
    t.string  "password"
    t.string  "name"
    t.string  "phone"
    t.string  "email"
    t.string  "staffid"
    t.integer "status",         :default => 0
    t.string  "confirm_token"
    t.string  "remember_token"
    t.integer "tasks",          :default => 0
    t.string  "image"
    t.integer "unread"
  end

  add_index "staffs", ["confirm_token"], :name => "index_staffs_on_confirm_token"
  add_index "staffs", ["email"], :name => "index_staffs_on_email"
  add_index "staffs", ["remember_token"], :name => "index_staffs_on_remember_token"

end
