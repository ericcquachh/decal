require 'spec_helper'

describe FacilitatorController do

	before :each do
		Course.create(title: "Flirting in French", category: "Languages", units: "2", status: "Full", pending: true)
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
		post :create, {"mugenjin@berkeley.edu" => "1"}, :course => course.id
	end
end