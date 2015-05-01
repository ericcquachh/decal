require 'spec_helper'

describe CoursesController do

  describe 'filtering courses' do
    before :each do
      Category.create!(name: "Computer Science")
      Category.create!(name: "Fitness")
      Category.create!(name: "Business")
      Category.create!(name: "Languages")
      Category.create!(name: "Cognitive Science")
      Semester.create!(name: "Spring 2015")
      Semester.create!(name: "Fall 2015")
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
      get :index, {:category => "All", :status => "All"}
      response.should render_template 'index'
      assigns(:courses).should == [course1, course2, course3, course4]
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
      get :index, {:status => "Open"}
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

        course = Course.create(title: "Python on Crack", category: "Computer Science", status: "Open", units: "3")
        put :update, {:id => 1, :title => "Intro to Python"}
      end

      it "should update" do
        course = Course.find(1)
        course.title == "Intro to Python"
      end

      it "should remove the course from the database" do
        delete :destroy, {:id => 1}
        begin
          course = Course.find(1)
        rescue ActiveRecord::RecordNotFound
          true
        end
      end

      it "should show the course if found in the database" do
        course = Course.create(title: "Intro to Banking", category: "Business", status: "Full", units: "2")
        get :show, {:id => 1}
      end

      it "should redirect to edit page when editing a course" do
        course = Course.create(title: "Intro to Banking", category: "Business", status: "Full", units: "2")
        get :edit, {:id => 1}
        # response.should render_template 'edit'
      end

      it "should make a new course" do
        get :new
        # response.should render_template 'new'
        course = Course.new(title: "Flirting in French", category: "Languages", status: "Full", units: "1")
        post :create, {:course => course}
        # response.should redirect_to course_path(2)
    end

  end

end
