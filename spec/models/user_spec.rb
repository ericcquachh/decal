require 'spec_helper'

describe User do

	#when creating an object, always use exclamation marks! Or, make sure to save()
	#after if decide to not use !
	describe 'facilitator and user relationship' do
		before :each do
			User.create!(:email => "felixliu@berkeley.edu", :password => "chickenlegs",
			:first_name => "felix", :last_name => "liu", :facilitator => true)
		end

		it 'should see that facilitators can have multiple courses' do
			user = User.find_by_first_name("felix")
			course1 = Course.create!(title: "Vacuum Cleaner", category: "Business", units: "3", status: "open")
			course2 = Course.create!(title: "Soap Opera", category: "Business", units: "3", status: "open")
			course1.update_attributes(uid: user.id)
			course2.update_attributes(uid: user.id)
			user.courses << course1
			user.courses << course2
			received1 = user.courses.find_by_title("Vacuum Cleaner")
			expect(received1).to eq(course1)
		end

		it 'should see that a course can have multiple facilitators' do
			
		end
	end

end
