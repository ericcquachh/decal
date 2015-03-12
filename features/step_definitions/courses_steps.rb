#comment used to test initial git push
Given /the following courses exist/ do |courses_table|
  courses_table.hashes.each do |course|
    input_course = Course.new
    input_course.title = course["title"]
    input_course.category = course["category"]
    input_course.units = course["units"]
    input_course.time = course["time"]
    input_course.status = course["status"]
    input_course.save
  end
end

When /I search the following title: (.*)/ do |search_field|
  puts search_field
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  assert page.body.index(e1) < page.body.index(e2)
end

When /I (un)?select the following categories: (.*)/ do |unselect, category_list|
  category_list.split(",").each do |category|
    category = "categories_#{category.strip}"
    unselect ? unselect(category) : select(category)
  end
end

When /I (un)?select the following status: (.*)/ do |unselect, status_list|
  status_list.split(/[\s,]+/).each do |status|
    status = "status_#{status.strip}"
    unselect ? unselect(status) : select(status)
  end
end

When /I (un)?check the following units: (.*)/ do |uncheck, unit_list|
  unit_list.split(/[\s,]+/).each do |unit|
    uncheck ? check(unit) : check(unit)
  end
end

When /I (un)?check the following day_of_week: (.*)/ do |uncheck, days_list|
  days_list.split(",").each do |day|
    day = "days_of_week_#{day.strip}"
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
