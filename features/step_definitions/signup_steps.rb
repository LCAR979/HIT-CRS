#encoding: utf-8
require 'uri'
require 'cgi'

And /^I start the testing$/ do
  puts "Started testing"
  DatabaseCleaner[:active_record, :connection => :test].start
end 

And /^I stop testing$/ do 
  puts "cleaning"
  DatabaseCleaner[:active_record, :connection => :test].clean
end 

Given /^I am on the (.+) page/ do |page_name|
  visit path_to(page_name)
end

And /^I click on (.+) button/ do |arg1|
  click_button(arg1)
end

Then /^I will goto (.+) page$/ do |page_name|
  visit path_to(arg1)
end

When /^I follow "(.*?)"$/ do |arg1|
  click_link(arg1)
end
And /^I fill in (.+) with (.+)$/ do |arg1, arg2|
  fill_in(arg1, :with => arg2)
end 
And /^I choose (.*)$/ do |arg1|
  choose(arg1)
end
And /^I click (.+)$/ do |arg1|
  click(arg1)
end 
And /^I should see "(.+)"$/ do |arg1|
  page.should have_content(arg1)
end
