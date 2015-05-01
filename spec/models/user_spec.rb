require 'spec_helper'

describe User do

	#when creating an object, always use exclamation marks! Or, make sure to save()
	#after if decide to not use !
	describe 'facilitator and user relationship' do
		before :each do
			Category.create!(name: "Computer Science")
			Category.create!(name: "Fitness")
			Category.create!(name: "Business")
			Category.create!(name: "Languages")
			Category.create!(name: "Cognitive Science")
			Semester.create!(name: "Spring 2015")
			Semester.create!(name: "Fall 2015")
			User.create!(:email => "felixliu@berkeley.edu", :password => "chickenlegs",
			:first_name => "felix", :last_name => "liu")
			User.create!(:email => "jamescheng@berkeley.edu", :password => "jalapenocheddar",
			:first_name => "james", :last_name => "cheng")
		end

		it 'should see that facilitators can have multiple courses' do
			user = User.find_by_first_name("felix")
			course1 = Course.create!(semester: "Spring 2015", title: "Flirting in French", category: "Computer Science",  units: 1, pending: false, description: 'hi', enrollment_info: 'hi', department_num: 1, course_email: "temp@berkeley.edu", faculty_email: "temp@berkeley.edu", faculty_name: "hi")  
			course2 = Course.create!(semester: "Fall 2015", title: "Ballmer Peak", category: "Cognitive Science", units: 1, pending: false, description: 'hi', enrollment_info: 'hi', department_num: 1, course_email: "temp@berkeley.edu", faculty_email: "temp@berkeley.edu", faculty_name: "hi") 
		end

		it 'should see that a course can have multiple facilitators' do
			course = Course.create!(semester: "Spring 2015", title: "Flirting in French", category: "Computer Science",  units: 1, pending: false, description: 'hi', enrollment_info: 'hi', department_num: 1, course_email: "temp@berkeley.edu", faculty_email: "temp@berkeley.edu", faculty_name: "hi")  
			user1 = User.find_by_first_name("felix")
			user2 = User.find_by_first_name("james")
		end
	end

end
