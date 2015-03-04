#comment used to test initial git push
Given /the following courses exist/ do |courses_table|
  courses_table.hashes.each do |course|
    Decal.new(course).save!
  end

end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  assert page.body.index(e1) < page.body.index(e2)
end

When /I (un)?select the following catagories: (.*)/ do |unselect, rating_list|
  catagory_list.split(",").each do |catagory|
    catagory = "catagories_#{catagory.strip}"
    unselect ? unselect(catagory) : select(catagory)
  end
end

When /I (un)?select the following status: (.*)/ do |unselect, status_list|
  status_list.split(",").each do |status|
    status = "status_#{status.strip}"
    unselect ? unselect(status) : select(status)
  end
end

When /I (un)?select the following units: (.*)/ do |unselect, unit_list|
  unit_list.split(",").each do |status|
    unit = "units_#{unit.strip}"
    unselect ? unselect(unit) : select(unit)
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

When /I search the following / do |movie, director|
  Movie.find_by_title(movie).director == director
end