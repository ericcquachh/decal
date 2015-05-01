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

    it "should not be a valid user" do
    	get :index
    end


end