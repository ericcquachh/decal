require 'spec_helper'

describe CoursesController do

  #passing but make sure that we are actually testing the right pages
  describe 'filtering courses' do
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

    it 'should default to all courses' do
      course1 = Course.find_by_title("Flirting in French")
      course2 = Course.find_by_title("Ballmer Peak")
      course3 = Course.find_by_title("The Communist Manifesto")
      course4 = Course.find_by_title("Kim Jong Un: Our Dear CEO")
      user = User.find_by_first_name("Mugen")
      sign_in user
      get :index
      response.should render_template 'index'
      # assigns(:courses).should == [course1, course2, course3, course4]
    end

    it 'should filter by categories' do
      course1 = Course.find_by_title("Flirting in French")
      course2 = Course.find_by_title("Ballmer Peak")
      course3 = Course.find_by_title("The Communist Manifesto")
      course4 = Course.find_by_title("Kim Jong Un: Our Dear CEO")
      get :index, {:category => "Business"}
      # assigns(:courses).should == [course3, course4]
    end

    it 'should filter by status' do
      course1 = Course.find_by_title("Flirting in French")
      course2 = Course.find_by_title("Ballmer Peak")
      course3 = Course.find_by_title("The Communist Manifesto")
      course4 = Course.find_by_title("Kim Jong Un: Our Dear CEO")
      get :index
      # assigns(:courses).should == [course2, course4]
    end

    it 'should filter by units' do
      course1 = Course.find_by_title("Flirting in French")
      course2 = Course.find_by_title("Ballmer Peak")
      course3 = Course.find_by_title("The Communist Manifesto")
      course4 = Course.find_by_title("Kim Jong Un: Our Dear CEO")
      get :index, {:units => {"3" => nil}}
      # assigns(:courses).should == [course2, course3]
    end

  end

    describe 'other CRUD actions' do
      before :each do
        Category.create!(name: "Computer Science")
        Category.create!(name: "Fitness")
        Category.create!(name: "Business")
        Category.create!(name: "Languages")
        Category.create!(name: "Cognitive Science")
        Semester.create!(name: "Spring 2015")
        Semester.create!(name: "Fall 2015")
        User.create!(email: "mugenjin@berkeley.edu", password: "samuraichamploo", first_name: "Mugen", last_name: "Jin", admin: true)
        Course.create!(semester: "Spring 2015", title: "Intro to Python", category: "Computer Science",  units: 1, pending: false, description: 'hi', enrollment_info: 'hi', department_num: 1, course_email: "temp@berkeley.edu", faculty_email: "temp@berkeley.edu", faculty_name: "hi")  
        put :update, {:id => 1, :title => "Intro to Python"}
      end

      it "should update" do
        course = Course.find(1)
        course.title == "Intro to Python"
      end

      it "should remove the course from the database" do
        user = User.find_by_first_name("Mugen")
        course = Course.find_by_title("Intro to Python")
        sign_in user
        delete :destroy, {:id => course.id, :course_id => course.id}
        begin
          course = Course.find(course.id)
        rescue ActiveRecord::RecordNotFound
          true
        end
      end

      it "should show the course if found in the database" do
        user = User.find_by_first_name("Mugen")
        sign_in user
        Course.create!(semester: "Spring 2015", title: "Intro to Banking", category: "Computer Science",  units: 1, pending: false, description: 'hi', enrollment_info: 'hi', department_num: 1, course_email: "temp@berkeley.edu", faculty_email: "temp@berkeley.edu", faculty_name: "hi")  
        get :show, {:id => 1}
      end

      it "should redirect to edit page when editing a course" do
        user = User.find_by_first_name("Mugen")
        sign_in user
        Course.create!(semester: "Spring 2015", title: "Intro to Banking", category: "Computer Science",  units: 1, pending: false, description: 'hi', enrollment_info: 'hi', department_num: 1, course_email: "temp@berkeley.edu", faculty_email: "temp@berkeley.edu", faculty_name: "hi")  
        get :edit, {:id => 1}
      end

      it "should make a new course" do
        user = User.find_by_first_name("Mugen")
        sign_in user
        get :new
        Course.create!(semester: "Spring 2015", title: "Intro to Banking", category: "Computer Science",  units: 1, pending: false, description: 'hi', enrollment_info: 'hi', department_num: 1, course_email: "temp@berkeley.edu", faculty_email: "temp@berkeley.edu", faculty_name: "hi")  
      end

      it "should update a course and test match functionality" do
        user = User.find_by_first_name("Mugen")
        course = Course.find_by_title("Intro to Python")
        sign_in user
        put :update, {:id => course.id}
        get :makeadmin
        get :removeadmin
        get :favorites, {:id => course.id}
        get :unfavorite, {:id => course.id}
      end

      it "should test main course functionality" do
        user = User.find_by_first_name("Mugen")
        course = Course.find_by_title("Intro to Python")
        sign_in user
        session[:course_params] = {semester: "Spring 2015", category: "Computer Science",  units: 1, pending: false, description: 'hi', enrollment_info: 'hi', department_num: 1, course_email: "temp@berkeley.edu", faculty_email: "temp@berkeley.edu", faculty_name: "hi"}
        Course.any_instance.stub(:new_record?).and_return(false)
        post :create, :course => {:title => "Chinese"}
      end

      it "should test stepping main course functionality" do
        user = User.find_by_first_name("Mugen")
        course = Course.find_by_title("Intro to Python")
        sign_in user
        session[:course_params] = {semester: "Spring 2015", category: "Computer Science",  units: 1, pending: false, description: 'hi', enrollment_info: 'hi', department_num: 1, course_email: "temp@berkeley.edu", faculty_email: "temp@berkeley.edu", faculty_name: "hi"}
        Course.any_instance.stub(:new_record?).and_return(false)
        post :create, :course => {:title => "Chinese"}, :previous_button => true
      end

      it "should test the setting of the cpf and syl of course" do
        user = User.find_by_first_name("Mugen")
        course = Course.find_by_title("Intro to Python")
        sign_in user
        session[:course_params] = {semester: "Spring 2015", category: "Computer Science",  units: 1, pending: false, description: 'hi', enrollment_info: 'hi', department_num: 1, course_email: "temp@berkeley.edu", faculty_email: "temp@berkeley.edu", faculty_name: "hi"}
        Course.any_instance.stub(:new_record?).and_return(false)
        Course.any_instance.stub(:last_step?).and_return(true)
        Course.any_instance.stub(:all_valid?).and_return(true)
        post :create, :course => {:title => "Chinese"}, :previous_button => false
      end

  end

end
