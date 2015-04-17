require 'spec_helper'

describe DashboardController do
	include Devise::TestHelpers

	before :each do
		user1 = User.create!(email: "mugenjin@berkeley.edu", password: "samuraichamploo",
			first_name: "Mugen", last_name: "Jin")
	end

	it "tests login" do
		current_user = User.create!(:email => "jamescheng@berkeley.edu", :password => "jalapenocheddar",
				:first_name => "James", :last_name => "Cheng")
		get :index, {:current_user => current_user}
	end

	it "tests params filtering" do
		user1 = User.find_by_email("mugenjin@berkeley.edu")
		sign_in user1
		flirt = Course.create(title: "Flirting in French", category: "Languages", units: "2", status: "Full", pending: true)
		CoursesUser.create!(:user_id => user1.id, :course_id => flirt.id)
		post :create, {"Flirting in French" => "1"}
		response.should redirect_to('/dashboard')
	end

	it "tests delete" do
		flirt = Course.create(title: "Flirting in French", category: "Languages", units: "2", status: "Full", pending: true)
		get :delete, :id => flirt.id
		course = Course.find_by_title("Flirting in French")
		course.should be_nil
		response.should redirect_to('/dashboard')
	end

end