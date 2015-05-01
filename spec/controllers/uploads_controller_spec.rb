require 'spec_helper'

describe UploadsController do
	include CarrierWave::Test::Matchers

	before :each do
		Category.create!(name: "Fitness")
		attachment = File.open(File.join(Rails.root, '/spec/test.pdf'))
		User.create!(email: "mugenjin@berkeley.edu", password: "samuraichamploo", first_name: "Mugen", last_name: "Jin", admin: true)
		Upload.create!(name: "Anna Huang", attachment: attachment)
		Upload.create!(name: "Nicole Feng", attachment: attachment)
		Course.create!(semester: "Spring 2015", title: "Flirting in French", category: "Fitness",  units: 1, pending: false, description: 'hi', enrollment_info: 'hi', department_num: 1, course_email: "temp@berkeley.edu", faculty_email: "temp@berkeley.edu", faculty_name: "hi")  
	end

	it "should test basic login" do
		course = Course.find_by_title("Flirting in French")
		user = User.find_by_first_name("Mugen")
		get :index, :course_id => course.id
		response.should be_success
		sign_in user
		get :index, :course_id => course.id
		response.should be_success
	end

	it "should test the new uploads page" do
		course = Course.find_by_title("Flirting in French")
		user = User.find_by_first_name("Mugen")
		sign_in user
		get :new, :course_id => course.id
		response.should be_success
	end	

	#make sure to write redirect matching soon
	it "should test the create uploads page" do
		course = Course.find_by_title("Flirting in French")
		user = User.find_by_first_name("Mugen")
		attachment = File.open(File.join(Rails.root, '/spec/test.pdf'))
		sign_in user
        Upload.any_instance.stub(:save).and_return(true)
		post :create, :course_id => course.id, :upload => {:name => "Albert Wang", :attachment => attachment}, :syl => true
		response.should redirect_to("/courses/#{course.id}")
        Upload.any_instance.stub(:syl).and_return(false)
        Upload.any_instance.stub(:cpf).and_return(true)
        Upload.any_instance.stub(:save).and_return(true)
 		post :create, :course_id => course.id, :upload => {:name => "Albert Wang", :attachment => attachment}, :syl => true
        Upload.any_instance.stub(:syl).and_return(false)
        Upload.any_instance.stub(:cpf).and_return(false)
        Upload.any_instance.stub(:save).and_return(true)
 		post :create, :course_id => course.id, :upload => {:name => "Albert Wang", :attachment => attachment}, :syl => true
        Upload.any_instance.stub(:syl).and_return(true)
        Upload.any_instance.stub(:cpf).and_return(true)
        Upload.any_instance.stub(:save).and_return(true)
 		post :create, :course_id => course.id, :upload => {:name => "Albert Wang", :attachment => attachment}, :syl => true
	end

	it "should test destroy uploads" do
		user = User.find_by_first_name("Mugen")
		course = Course.find_by_title("Flirting in French")
		upload = Upload.find_by_name("Anna Huang")
		upload.course = course
		upload.save!
		sign_in user
        Upload.any_instance.stub(:syl).and_return(true)
		delete :destroy, :id => upload.id, :course_id => course.id
		response.should redirect_to("/courses/#{course.id}")
		upload = Upload.find_by_name("Nicole Feng")
		upload.course = course
		upload.save!

        Upload.any_instance.stub(:syl).and_return(false)
        Upload.any_instance.stub(:cpf).and_return(true)
		delete :destroy, :id => upload.id, :course_id => course.id
		response.should redirect_to("/courses/#{course.id}")
	end
end
