require 'spec_helper'

describe DashboardController do
	include Devise::TestHelpers

	before :each do
		Category.create!(name: "Fitness")
		User.create!(email: "mugenjin@berkeley.edu", password: "samuraichamploo",
			first_name: "Mugen", last_name: "Jin")
		Course.create!(semester: "Spring 2015", title: "Flirting in French", category: "Fitness",  units: 1, pending: false, description: 'hi', enrollment_info: 'hi', department_num: 1, course_email: "temp@berkeley.edu", faculty_email: "temp@berkeley.edu", faculty_name: "hi")  

	end

	it "tests login" do
		user1 = User.find_by_first_name("Mugen")
		get :index
		response.should_not be_success
	end

	# it "tests params filtering and delete" do
	# 	user1 = User.find_by_email("mugenjin@berkeley.edu")
	# 	sign_in user1
	# 	flirt = Course.find_by_title("Flirting in French")
	# 	FacilitateOwnedcourse.create!(:ownedcourse_id => flirt.id, :facilitator_id => user1.id)
	# end

end