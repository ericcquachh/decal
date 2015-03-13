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



end
