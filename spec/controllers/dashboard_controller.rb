require 'spec_helper'

describe DashboardController do
	include Devise::TestHelpers

	before :each do
		# obj = double()
		# obj.stub(:current_user) {User.new}
		# obj.stub(:authenticate) { return true }
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
		flirt = Course.create(title: "Flirting in French", category: "Languages", units: "2", status: "Full", pending: true)
		CoursesUser.create!(:user_id => user1.id, :course_id => flirt.id)
		post :create, :parameters => {"Flirting in French" => "1"}


		# response.should be_success
		# response.should render_template ''
		# puts response
	end
end