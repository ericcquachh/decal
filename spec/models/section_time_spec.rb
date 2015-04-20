require 'spec_helper'

describe Section_time do
	it "should run through all basic functionality of Section Time" do
		all_days = Section_time.all_days
		all_days[0] == "M"
		all_times = Section_time.all_times
		section_time = Section_time.create!(:days => "M")
		section_time.full_time
		section_time.include_day? "W"
		section_time.include_time? :start_time => "2:00"
		Section_time.time_to_int "2:00"
	end
end