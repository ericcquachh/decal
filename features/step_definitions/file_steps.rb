Then /^(?:|I )should see a "([^\"]*)" button$/ do |text|
   page.should have_selector("input[type=submit][value='New Upload']")
end

Then(/^I should not see a "(.*?)" button$/) do |arg1|
  page.should have_no_selector("input[type=submit][value='New Upload']")
end

When(/^I upload a file called "(.*?)"$/) do |arg1|
	RAILS_ROOT = File.join(File.expand_path('../../',File.dirname(__FILE__)))
	attach_file("upload_attachment", File.join(RAILS_ROOT, 'features', 'upload-files', arg1))
	fill_in("upload_name", :with => "test.pdf")
	click_button("Save")
end
