require 'spec_helper'

describe FavoriteCourse do

	describe 'favorites table creation' do
		before :each do
			User.create!(:email => "felixliu@berkeley.edu", :password => "chickenlegs",
			:first_name => "felix", :last_name => "liu")
			User.create!(:email => "jamescheng@berkeley.edu", :password => "jalapenocheddar",
			:first_name => "james", :last_name => "cheng")
			Course.create!(title: "Vacuum Cleaner", category: "Business", units: "3", status: "Open")
			Course.create!(title: "Soap Opera", category: "Business", units: "3", status: "Open")
		end

		it 'should test basic sanity of User/Course Favorite' do
			user = User.find_by_first_name('felix')
			course1 = Course.find_by_title('Vacuum Cleaner')
			course2 = Course.find_by_title('Soap Opera')
			FavoriteCourse.create!(course_id: course1.id, user_id: user.id)
			FavoriteCourse.create!(course_id: course2.id, user_id: user.id)
		end
	end
end
