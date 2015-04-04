#comment used to test initial git push
#course
def mock_course
  @mock_course = { :title=>"Test Course", :category=>"Business", :units=>"3", :status=>"Open" }
  @course = Course.create(@mock_course)
end

def create_course
  visit 'courses/new'
  fill_in "course_title", :with => @mock_course[:title]
  select(@mock_course[:category], :from => "course_category")
  fill_in "course_units", :with => @mock_course[:units]
  select(@mock_course[:status], :from => "course_status")
  click_button "Create Course"
end

Given /^I create a course$/ do
  mock_course
  create_course
end

Then /^my course should exist in home page$/ do 
  page.should have_content "Test Course"
end


Given /the following courses exist/ do |courses_table|
  courses_table.hashes.each do |course|
    Course.create!(course)
  end
end

And /I set everything to default/ do
  select("All", :from => "category")
  select("All", :from => "status")
  (1..4).each {|i| uncheck "units[#{i.to_s}]"}
  Course.days.each {|d| uncheck "days[#{d}]"}
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  assert page.body.index(e1) < page.body.index(e2)
end

When /I (un)?select the following categories: (.*)/ do |unselect, category_list|
  category_list.split(",").each do |category|
    unselect ? unselect(category) : select(category)
  end
end

When /I (un)?select the following status: (.*)/ do |unselect, status_list|
  status_list.split(/[\s,]+/).each do |status|
    unselect ? unselect(status) : select(status)
  end
end

When /I (un)?check the following units: (.*)/ do |uncheck, unit_list|
  unit_list.split(/[\s,]+/).each do |unit|
    uncheck ? uncheck(unit) : check(unit)
  end
end

When /I (un)?check the following days_of_week: (.*)/ do |uncheck, days_list|
  days_list.split(",").each do |day|
    day = "days[#{day.strip}]"
    uncheck ? uncheck(day) : check(day)
  end
end

When /I (un)?select the following starting_time: (.*)/ do |unselect, starting_time_list|
  starting_time_list.split(",").each do |starting_time|
    starting_time = "starting_times_#{starting_time.strip}"
    unselect ? unselect(starting_time) : select(starting_time)
  end
end

When /I (un)?select the following ending_time: (.*)/ do |unselect, ending_time_list|
  ending_time_list.split(",").each do |ending_time|
    ending_time = "ending_times_#{ending_time.strip}"
    unselect ? unselect(ending_time) : select(ending_time)
  end
end

#Felix's step for facilitate_course
Given(/^the following users exist:$/) do |users_table|
  users_table.rows_hash.each do |user|
    input_user = User.new
    input_user.email = user["email"]
    input_user.first_name = user["first name"]
    input_user.last_name = user["last name"]
    input_user.password = user["password"]
    input_user.save
  end
  # table is a Cucumber::Ast::Table
end

Then(/^I should see the course page$/) do
  puts "yayyy"
end

