require 'spec_helper'

describe AdminController do

	before :each do
		#Factory Girl if time permits
		User.create!(email: "mugenjin@berkeley.edu", password: "samuraichamploo", first_name: "Mugen", last_name: "Jin", admin: true)
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
		user = User.find_by_first_name("Mugen")
		sign_in user
		get :index
		response.should be_success
		get :index, :tab => 'manageadmins'
		response.should be_success
	end

	it "should create a particular param" do
		get :create, 'Flirting in French' => '1'
		response.should redirect_to('/')
		get :create, 'Flirting in Chinese' => '1'
		response.should redirect_to('/')
	end

	it "should test the create functionality" do
		user = User.find_by_first_name("Mugen")
		course1 = Course.find_by_title("Flirting in French")
		course2 = Course.find_by_title("Flirting in Chinese")
		sign_in user
		post :create, :course_ids => {"#{course1.id}" => "something", "#{course2.id}" => "something else"}
        Course.any_instance.stub(:pending).and_return(true)
		post :create, :course_ids => {"#{course1.id}" => "something", "#{course2.id}" => "something else"}
	end

	it "should test all the match functionalities" do
		user = User.find_by_first_name("Mugen")
		sign_in user
		FacilitateOwnedcourse.stub(:destroy)
		post :remove_facilitators, :relation_ids => {"1" => "junk", "2" => "more junk"}
		get :add_semester, :semester => {:name => "Fall 2022"}
		get :add_category, :category => {:name => "Gender Women Studies"}
		post :remove_semester, :semester => "Fall 2015"
		post :remove_category, :category => "Computer Science"
	end
end
