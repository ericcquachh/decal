require 'spec_helper'

describe UploadsController do
	before :each do
		Upload.create!(name: "Anna Huang", attachment: "not_attached.pdf")
		Upload.create!(name: "Nicole Feng", attachment: "not_attached.pdf")
		Course.create(title: "Flirting in French", category: "Languages", units: "2", status: "Full", pending: true)
	end

	it "should test the main index page" do
		course = Course.find_by_title("Flirting in French")
		get :index, :course_id => course.id
		# response.body.should match(/Flirting in French/)
		response.should be_success
	end

	it "should test the new uploads page" do
		course = Course.find_by_title("Flirting in French")
		get :new, :course_id => course.id
		response.should be_success
	end	

	it "should test the create uploads page" do
		course = Course.find_by_title("Flirting in French")
		get :create, :course_id => course.id, :upload => {:name => "Albert Wang", attachment: "hella_attached.pdf"}
		get :create, :course_id => course.id
		response.should redirect_to("/courses/#{course.id}")
	end

	it "should test destroy uploads" do
		course = Course.find_by_title("Flirting in French")
		upload = Upload.find_by_name("Anna Huang")
		get :destroy, :id => upload.id, :course_id => course.id
		response.should redirect_to("/courses/#{course.id}")
	end
end
