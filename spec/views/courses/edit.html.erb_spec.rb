require 'spec_helper'

describe "courses/edit" do
  before(:each) do
    @course = assign(:course, stub_model(Course,
      :title => "MyString",
      :category => "MyString",
      :units => "MyString",
      :time => "MyString",
      :status => "MyString"
    ))
  end

  it "renders the edit course form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", course_path(@course), "post" do
      assert_select "input#course_title[name=?]", "course[title]"
      assert_select "input#course_category[name=?]", "course[category]"
      assert_select "input#course_units[name=?]", "course[units]"
      assert_select "input#course_time[name=?]", "course[time]"
      assert_select "input#course_status[name=?]", "course[status]"
    end
  end
end
