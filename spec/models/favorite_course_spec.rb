require 'spec_helper'

describe FavoriteCourse do

	describe 'favorites table creation' do
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
			Course.create!(semester: "Spring 2015", title: "A", description: "bleh", enrollment_info: "enrolled", category: "Business", status: "Open", units: 1, pending: false) 
			Course.create!(semester: "Fall 2015", title: "B", description: "bleh", enrollment_info: "enrolled", category: "Cognitive Science", status: "Open", units: 1, pending: false) 
		end

		it 'should test basic sanity of User/Course Favorite' do
			user = User.find_by_first_name('felix')
			course1 = Course.find_by_title('A')
			course2 = Course.find_by_title('B')
			FavoriteCourse.create!(course_id: course1.id, user_id: user.id)
			FavoriteCourse.create!(course_id: course2.id, user_id: user.id)
		end
	end
end
