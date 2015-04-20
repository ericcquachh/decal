require 'spec_helper'

describe FacilitatorController do

	before :each do
		Course.create!(title: "Flirting in French", category: "Languages", units: "2", status: "Full", pending: true)
		User.create!(email: "mugenjin@berkeley.edu", password: "samuraichamploo",
			first_name: "Mugen", last_name: "Jin")
	end

	it "runs the index page" do
		course = Course.find_by_title("Flirting in French")
		get :index, :course => course.id, :search_field => "mugen"
		response.should be_success
		get :index, :course => course.id
		response.should be_success
	end

	it "should create a new relation between course and user" do
		course = Course.find_by_title("Flirting in French")
		post :create, "mugenjin@berkeley.edu" => "1", :course => course.id
		response.should redirect_to("/courses/#{course.id}")
	end

	it "should delete the relation between a user and course" do
		user = User.find_by_first_name("Mugen")
		course = Course.find_by_title("Flirting in French")
		CoursesUser.create!(:user_id => user.id, :course_id => course.id)
		post :delete, :user => user.id, :course => course.id
		response.should redirect_to("/courses/#{course.id}")
	end
end