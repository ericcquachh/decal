require 'spec_helper'

describe "courses/new" do
  before(:each) do
    assign(:course, stub_model(Course,
      :title => "MyString",
      :category => "MyString",
      :units => "MyString",
      :time => "MyString",
      :status => "MyString"
    ).as_new_record)
  end

  it "renders new course form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", courses_path, "post" do
      assert_select "input#course_title[name=?]", "course[title]"
      assert_select "input#course_category[name=?]", "course[category]"
      assert_select "input#course_units[name=?]", "course[units]"
      assert_select "input#course_time[name=?]", "course[time]"
      assert_select "input#course_status[name=?]", "course[status]"
    end
  end
end
