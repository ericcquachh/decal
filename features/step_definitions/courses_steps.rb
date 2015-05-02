#comment used to test initial git push
#course

Category.create!(name: "Computer Science")
Category.create!(name: "Business")
Category.create!(name: "Languages")

Semester.create!(name: "Spring 2015")

def mock_course
  @mock_course = { :title=>"Test Course", :category=>"Business", :units=>"3", :status=>"Open" }
end

def create_course
  visit 'courses/new'
  fill_in "course_title", :with => @mock_course[:title]
  select(@mock_course[:category], :from => "course_category")
  fill_in "course_units", :with => @mock_course[:units]
  select(@mock_course[:status], :from => "course_status")
  click_button "Create Course"
end

def mock_section
  @mock_section = { :section_section_title=>"Test Section", :section_ccn_ld=>"123456", :section_ccn_ud=>"234566", :section_size=>"50" }
end

def mock_section
  @mock_section = { :section_section_title=>"Test Section", :section_ccn_ld=>"123456", :section_ccn_ud=>"234566", :section_size=>"50" }
end

def create_section
  click_link 'Test Course'
  click_button 'Add Section'
  fill_in "section_section_title", :with => @mock_section[:section_section_title]
  fill_in "section_ccn_ld", :with => @mock_section[:section_ccn_ld]
  fill_in "section_ccn_ud", :with => @mock_section[:section_ccn_ud]
  fill_in "section_size", :with => @mock_section[:section_size]
  click_button "Create Section"
end

Given /^I visit the course dashboard page/ do
  visit '/dashboard'
end

When /^I click on "([^"]*)" course/ do |name|
  visit '/courses/1'
end

Then /^I should not see "([^"]*)" button/ do |name|
  should have_no_button name
end

Then /^I should see my new section in facilitate course page$/ do
  page.should have_content "Test Section"
end

Given /^I visit facilitate course page$/ do
  visit '/dashboard'
end

Then /^I create a new section$/ do
  mock_section
  create_section
end

Given /^I create a course$/ do
  mock_course
  create_course
end

Given /^I create a course with invalid fields$/ do
  mock_course
  @mock_course = @mock_course.merge(:units=>"bad units")
  create_course
end

Given /^another facilitator has created a course$/ do
  steps %Q{
    Given I log out
    When I sign in as another facilitator
  }
  mock_course
  @mock_course = @mock_course.merge(:title=>"Other Course")
  create_course
  steps %Q{
    Given I log out
  }
  @facilitator = { :facilitator=>true, :first_name => "first", :last_name => "last", :email => "facilitator@berkeley.edu",
  :password => "testingpass", :password_confirmation => "testingpass" }
  visit 'users/sign_in'
  fill_in "user_email", :with => @facilitator[:email]
  fill_in "user_password", :with => @facilitator[:password]
  click_button "Sign in"

end

Then /^the page should have an error$/ do 
  page.should have_content "Error:"
end

Then /^my course should exist in home page$/ do 
  page.should have_content "Test Course"
end

Then /^my course should not exist in home page$/ do 
  page.should_not have_content "Test Course"
end

Then /^page should not have add course button$/ do 
  page.should_not have_content "Add New Course"
end
  

Given(/^these courses exist:$/) do |courses_table|
  courses_table.hashes.each do |course|
    input_course = Course.new
    input_course.title = course["Title"]
    input_course.category = course["Category"]
    input_course.units = course["Units"]
    input_course.pending = course["Pending"]
    input_course.department_num = course["Dep Num"]
    input_course.faculty_email = course["Faculty Email"]
    input_course.faculty_name = course["Faculty Name"]
    input_course.semester = "Spring 2015"
    input_course.save!
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
  users_table.hashes.each do |user|
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

Then(/^I should not see that course$/) do
  if page.respond_to? :should
    page.should have_no_content("Other Course")
  else
    assert page.has_no_content?("Other Course")
  end
end

Then /^I should be able to see the link "([^"]*)"$/ do |link|
  page.should have_link(link)
end

Then /^I should not be able to see the link "([^"]*)"$/ do |link|
  page.should have_no_link(link)
end

# Iteration 3-2
When /^(?:|I )press "([^"]*)"$/ do |button|
  click_button(button)
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end

def pending_course_info
  @pending_course_info = {:pending=>true, :title=>"Test Course", :semester => "Spring 2015", :units => 2, :category => "Computer Science", :department_num => "CS 200", :course_email => "contact@berkeley.edu",
    :course_website => "http://www.course.com", :faculty_name => "Faculty God", :faculty_email => "faculty@berkeley.edu", :description => "Awesome class!", :enrollment_info => "Lottery", :has_cpf => true, :has_syl => true}
end

Given /^I submitted a new course request form with valid fields/ do
  @p_course = Course.create!(pending_course_info)
  FacilitateOwnedcourse.create!(facilitator_id: @user.id, ownedcourse_id: @p_course.id)
  #select(@pending_course_info[:semester], :from => "course_semester")
  #fill_in "course_title", :with => @pending_course_info[:title]
  #fill_in "course_department_num", :with => @pending_course_info[:department_num]
  #select(@pending_course_info[:category], :from => "course_category")
  #fill_in "course_units", :with => @pending_course_info[:units]

  #fill_in "course_course_email", :with => @pending_course_info[:course_email]
  #fill_in "course_course_website", :with => @pending_course_info[:course_website]
  #fill_in "course_faculty_name", :with => @pending_course_info[:faculty_name]
  #fill_in "course_faculty_email", :with => @pending_course_info[:faculty_email]
  #click_button "continue"

  #fill_in "course_description_ifr", :with => @pending_course_info[:description]
  #click_button "continue"

  #fill_in "course_enrollment_info_ifr", :with => @pending_course_info[:enrollment_info]
  #click_button "continue"
end

Given /^my course "([^"]*)" is approved/ do |title|
  @my_course = Course.find_by_title(title)
  @p_course.pending = false
  @p_course.save
end
  
Given /^I input invalid fields in the new course request form$/ do
  fill_in "course_units", :with => 10
end

Given /^I leave incomplete fields in the new course request form$/ do
  pending_course_info
  fill_in "course_title", :with => @pending_course_info[:title]
  select(@pending_course_info[:category], :from => "course_category")
  fill_in "course_units", :with => @pending_course_info[:units]
  select(@pending_course_info[:status], :from => "course_status")
  click_button "continue"
end

When /^I add facilitators for my course/ do 
  visit "/courses/1/facilitator"
end

When /^I search for "([^"]*)"/ do |name|
  fill_in "search_field", :with => name
  click_button "search"
end
  
