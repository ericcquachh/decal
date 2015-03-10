require 'spec_helper'

describe "courses/index" do
  before(:each) do
    assign(:courses, [
      stub_model(Course,
        :title => "Title",
        :category => "Category",
        :units => "Units",
        :time => "Time",
        :status => "Status"
      ),
      stub_model(Course,
        :title => "Title",
        :category => "Category",
        :units => "Units",
        :time => "Time",
        :status => "Status"
      )
    ])
  end

  it "renders a list of courses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Category".to_s, :count => 2
    assert_select "tr>td", :text => "Units".to_s, :count => 2
    assert_select "tr>td", :text => "Time".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
  end
end
