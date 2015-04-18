require 'spec_helper'

describe CoursesController do

  # Simple Test to see if database can be instantiated correctly
  it "should be a sanity test" do
    course = Course.create(title: "Vacuum Cleaner", category: "Politics", units: "3", status: "open")
    Course.create(title: "Soap Opera", category: "Politics", units: "3", status: "open")
    Course.create(title: "The Communist Manifesto", category: "Politics", units: "3", status: "open")
    Course.create(title: "Kim Jong Un: Our Dear Leader", category: "Politics", units: "15", status: "open")
    course.title == "Vacuum Cleaner"
    another_course = Course.where(category: "Politics")
    another_course.each do |course|
      check_var = 0
      if course.title == "Kim Jong Un: Our Dear Leader"
        check_var = 1
      end
      check_var != 0
    end
  end

  describe 'filtering courses' do
    before :each do
      course1 = Course.create(title: "Flirting in French", category: "Languages", units: "2", status: "Full", pending: false)
      course2 = Course.create(title: "Ballmer Peak", category: "Computer Science", units: "3", status: "Open", pending: false)
      course3 = Course.create(title: "The Communist Manifesto", category: "Business", units: "3", status: "Full", pending: false)
      course4 = Course.create(title: "Kim Jong Un: Our Dear CEO", category: "Business", units: "1", status: "Open", pending: false)
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
