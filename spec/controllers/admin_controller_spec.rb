require 'spec_helper'

describe AdminController do

	before :each do
		#Factory Girl if time permits
		Category.create!(name: "Computer Science")
		Category.create!(name: "Fitness")
		Category.create!(name: "Business")
		Category.create!(name: "Languages")
		Category.create!(name: "Cognitive Science")
		Semester.create!(name: "Spring 2015")
		Semester.create!(name: "Fall 2015")
		Course.create!(semester: "Spring 2015", title: "Flirting in French", category: "Fitness",  units: 1, pending: false, description: 'hi', enrollment_info: 'hi', department_num: 1, course_email: "temp@berkeley.edu", faculty_email: "temp@berkeley.edu", faculty_name: "hi")  
		Course.create!(semester: "Fall 2015", title: "Flirting in Chinese", category: "Fitness", units: 1, pending: false, description: 'hi', enrollment_info: 'hi', department_num: 1, course_email: "temp@berkeley.edu", faculty_email: "temp@berkeley.edu", faculty_name: "hi") 
	end

	it "should test the admin index functionality" do
		#my god ted, this was the only thing i can think of to test it
		get :index
	end

	it "should create a particular param" do
		get :create, 'Flirting in French' => '1'
		response.should redirect_to('/')
		get :create, 'Flirting in Chinese' => '1'
		response.should redirect_to('/')
	end


end