Then /^(?:|I )should see a "([^"]*)" button$/ do |text|
   page.should have_selector("input[type=submit][value='New Upload']")
end

Then(/^I should not see a "(.*?)" button$/) do |arg1|
  page.should have_no_selector("input[type=submit][value='New Upload']")
end

When(/^I upload a file called "(.*?)"$/) do |arg1|
	attach_file(:pdf_file, File.join(RAILS_ROOT, 'features', 'upload-files', arg1))
	
end
