#comment used to test initial git push
Given /the following courses exist/ do |courses_table|
  courses_table.hashes.each do |course|
    Course.create!(course)
  end
end

And /I set everything to default/ do
  select("All", :from => "category")
  select("All", :from => "status")
  (1..4).each {|i| uncheck "units[#{i.to_s}]"}
  Course.days.each {|d| uncheck "days[#{d}]"}
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  assert page.body.index(e1) < page.body.index(e2)
end

When /I (un)?select the following categories: (.*)/ do |unselect, category_list|
  category_list.split(",").each do |category|
    unselect ? unselect(category) : select(category)
  end
end

When /I (un)?select the following status: (.*)/ do |unselect, status_list|
  status_list.split(/[\s,]+/).each do |status|
    unselect ? unselect(status) : select(status)
  end
end

When /I (un)?check the following units: (.*)/ do |uncheck, unit_list|
  unit_list.split(/[\s,]+/).each do |unit|
    uncheck ? uncheck(unit) : check(unit)
  end
end

When /I (un)?check the following days_of_week: (.*)/ do |uncheck, days_list|
  days_list.split(",").each do |day|
    day = "days[#{day.strip}]"
    uncheck ? uncheck(day) : check(day)
  end
end

When /I (un)?select the following starting_time: (.*)/ do |unselect, starting_time_list|
  starting_time_list.split(",").each do |starting_time|
    starting_time = "starting_times_#{starting_time.strip}"
    unselect ? unselect(starting_time) : select(starting_time)
  end
end

When /I (un)?select the following ending_time: (.*)/ do |unselect, ending_time_list|
  ending_time_list.split(",").each do |ending_time|
    ending_time = "ending_times_#{ending_time.strip}"
    unselect ? unselect(ending_time) : select(ending_time)
  end
end
