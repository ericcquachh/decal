require 'spec_helper'

describe Section do
	describe "all the functions of the Section model" do
		before :each do
			Category.create!(name: "Computer Science")
			Category.create!(name: "Fitness")
			Category.create!(name: "Business")
			Category.create!(name: "Languages")
			Category.create!(name: "Cognitive Science")
			Semester.create!(name: "Spring 2015")
			Semester.create!(name: "Fall 2015")
			User.create!(:email => "felixliu@berkeley.edu", :password => "chickenlegs",
			:first_name => "felix", :last_name => "liu")
			User.create!(:email => "jamescheng@berkeley.edu", :password => "jalapenocheddar",
			:first_name => "james", :last_name => "cheng")
		end

		it "should see the input days of filter" do
			input = {:days => ['M', 'W', 'F']}
			output = {}
			Course.filter input, output
		end

		it "should touch all the personal functions" do
			Section.all_days.should eq(["M", "Tu", "W", "Th", "F"])
			Section.all_times
			Section.statuses.should eq(["Open", "Full"])
			section = Section.create!(section_title: "3", days: "ThF", status: "Full", start_time: Section.time_to_int("10:00AM"), end_time: Section.time_to_int("11:00AM"), location: "186 Barrows")
			section.filled?
			section.full_time
		end
	end
end