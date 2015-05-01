require 'spec_helper'

describe FacilitatorController do

	before :each do
		Category.create!(name: "Fitness")
		Course.create!(semester: "Spring 2015", title: "Flirting in French", category: "Fitness",  units: 1, pending: false, description: 'hi', enrollment_info: 'hi', department_num: 1, course_email: "temp@berkeley.edu", faculty_email: "temp@berkeley.edu", faculty_name: "hi")  
		User.create!(email: "mugenjin@berkeley.edu", password: "samuraichamploo",
			first_name: "Mugen", last_name: "Jin", admin: true)
	end

	it "sees if the user is a facilitator" do
		course = Course.find_by_title("Flirting in French")
		get :index, :course_id => course.id
		response.should_not be_success
		user = User.find_by_first_name("Mugen")
		sign_in user
		get :index, :course_id => course.id
		response.should be_success
	end

	it "should create a new relation between course and user" do
		course = Course.find_by_title("Flirting in French")
		user = User.find_by_first_name("Mugen")
		sign_in user
		post :create, :user_id => user.id, :course_id => course.id
		response.should redirect_to("/courses/#{course.id}")
		post :delete, :user_id => user.id, :course_id => course.id
		post :create, :user_id => user.id, :course_id => course.id, :page => 'manual'
		response.should redirect_to course_facilitator_index_path(:course_id => course.id)
		post :delete, :user_id => user.id, :course_id => course.id, :page => 'dashboard'
		response.should redirect_to dashboard_index_path
	end

end