require 'spec_helper'

describe ExistingCoursesController do
	include Devise::TestHelpers

	before :each do
		user1 = User.create!(email: "mugenjin@berkeley.edu", password: "samuraichamploo",
			first_name: "Mugen", last_name: "Jin")
		flirt = Course.create!(title: "Flirting in French", category: "Languages", units: "2", status: "Full", pending: true)
		User.create!(email: "jetspike@berkeley.edu", password: "cowboybebop",
			first_name: "Jet", last_name: "Spike")
		CoursesUser.create!(:user_id => user1.id, :course_id => flirt.id)
	end

	it "should do index" do
		get :index
		user = User.find_by_first_name("Mugen")
		flirt = Course.find_by_title("Flirting in French")
		sign_in user
		get :index
	end

	it "should do create" do
		user = User.find_by_first_name("Mugen")
		flirt = Course.find_by_title("Flirting in French")
		sign_in user
		get :create, "Flirting in French" => "1"
	end

end
