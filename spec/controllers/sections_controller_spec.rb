require 'spec_helper'

describe SectionsController do

    before :each do
      Category.create!(name: "Computer Science")
      Category.create!(name: "Fitness")
      Category.create!(name: "Business")
      Category.create!(name: "Languages")
      Category.create!(name: "Cognitive Science")
      Semester.create!(name: "Spring 2015")
      Semester.create!(name: "Fall 2015")
      User.create!(email: "mugenjin@berkeley.edu", password: "samuraichamploo", first_name: "Mugen", last_name: "Jin", admin: true)
      course1 = Course.create!(semester: "Spring 2015", title: "Flirting in French", category: "Computer Science",  units: 1, pending: false, description: 'hi', enrollment_info: 'hi', department_num: 1, course_email: "temp@berkeley.edu", faculty_email: "temp@berkeley.edu", faculty_name: "hi")  
      course2 = Course.create!(semester: "Fall 2015", title: "Ballmer Peak", category: "Cognitive Science", units: 1, pending: false, description: 'hi', enrollment_info: 'hi', department_num: 1, course_email: "temp@berkeley.edu", faculty_email: "temp@berkeley.edu", faculty_name: "hi") 
      course3 = Course.create!(semester: "Spring 2015",title: "The Communist Manifesto", category: "Computer Science", units: '1-2', pending: false, description: 'hi', enrollment_info: 'hi', department_num: 1, course_email: "temp@berkeley.edu", faculty_email: "temp@berkeley.edu", faculty_name: "hi") 
      course4 = Course.create!(semester: "Fall 2015",title: "Kim Jong Un: Our Dear CEO", category: "Fitness", units: '1-2', pending: false, description: 'hi', enrollment_info: 'hi', department_num: 1, course_email: "temp@berkeley.edu", faculty_email: "temp@berkeley.edu", faculty_name: "hi") 
    end

    it "should be a valid user and able to get a new section" do
    	course = Course.find_by_title("Ballmer Peak")
    	user = User.find_by_first_name("Mugen")
    	sign_in user
    	get :new, :course_id => course.id
    end

    it "should create and destroy a section" do
    	course = Course.find_by_title("Ballmer Peak")
    	user = User.find_by_first_name("Mugen")
    	sign_in user
    	post :create, :course_id => course.id, :section => {section_title: "2", days: ['M','W','F'], status: "Full", start_time: "9:00AM", end_time: "10:00AM", location: "186 Barrows"}
    	section = Section.find_by_section_title("2")
    	delete :destroy, :course_id => course.id, :id => section.id
    end

    it "should create, edit, and, update a section" do
    	course = Course.find_by_title("Ballmer Peak")
    	user = User.find_by_first_name("Mugen")
    	sign_in user
    	post :create, :course_id => course.id, :section => {section_title: "2", days: ['M','W','F'], status: "Full", start_time: "9:00AM", end_time: "10:00AM", location: "186 Barrows"}
    	section = Section.find_by_section_title("2")
    	get :edit, :course_id => course.id, :id => section.id
    	put :update, :course_id => course.id, :id => section.id
	    Section.any_instance.stub(:update_attributes).and_return(false)
    	put :update, :course_id => course.id, :id => section.id
    	delete :destroy, :course_id => course.id, :id => section.id
    	Section.any_instance.stub(:valid?).and_return(false)
    	post :create, :course_id => course.id, :section => {section_title: "2", days: ['M','W','F'], status: "Full", start_time: "9:00AM", end_time: "10:00AM", location: "186 Barrows"}
    end

end
