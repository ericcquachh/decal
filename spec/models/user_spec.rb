require 'spec_helper'

describe User do

	#when creating an object, always use exclamation marks! Or, make sure to save()
	#after if decide to not use !
	describe 'facilitator and user relationship' do
		before :each do
			User.create!(:email => "felixliu@berkeley.edu", :password => "chickenlegs",
			:first_name => "felix", :last_name => "liu")
			User.create!(:email => "jamescheng@berkeley.edu", :password => "jalapenocheddar",
			:first_name => "james", :last_name => "cheng")
		end

		it 'should see that facilitators can have multiple courses' do
			user = User.find_by_first_name("felix")
			course1 = Course.create!(title: "Vacuum Cleaner", category: "Business", units: "3", status: "Open")
			course2 = Course.create!(title: "Soap Opera", category: "Business", units: "3", status: "Open")
			CoursesUser.create!(course_id: course1.id, user_id: user.id)
			CoursesUser.create!(course_id: course2.id, user_id: user.id)

			received1 = user.courses.find_by_title("Vacuum Cleaner")
			expect(received1).to eq(course1)
		end

		it 'should see that a course can have multiple facilitators' do
			course = Course.create!(title: "Vacuum Cleaner", category: "Business", units: "3", status: "Open")
			user1 = User.find_by_first_name("felix")
			user2 = User.find_by_first_name("james")
			CoursesUser.create!(course_id: course.id, user_id: user1.id)
			CoursesUser.create!(course_id: course.id, user_id: user2.id)
			received_user1 = course.users.find_by_first_name("felix")
			expect(received_user1).to eq(user1)
		end
	end

end
