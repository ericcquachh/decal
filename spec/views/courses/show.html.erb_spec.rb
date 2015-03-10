require 'spec_helper'

describe "courses/show" do
  before(:each) do
    @course = assign(:course, stub_model(Course,
      :title => "Title",
      :category => "Category",
      :units => "Units",
      :time => "Time",
      :status => "Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Category/)
    rendered.should match(/Units/)
    rendered.should match(/Time/)
    rendered.should match(/Status/)
  end
end
