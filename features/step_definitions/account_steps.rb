

def create_visitor
  @visitor = { :class_level=>"Senior", :first_name => "first", :last_name => "last", :email => "testing@berkeley.edu",
    :password => "testingpass", :password_confirmation => "testingpass"}
end

def create_non_facilitator
  @non_facilitator = {:facilitator=>false, :class_level=>"Senior", :first_name => "first", :last_name => "last", :email => "non_facilitator@berkeley.edu",
    :password => "testingpass", :password_confirmation => "testingpass"}
  @user = User.create(@non_facilitator)
end


def create_facilitator
  @facilitator = {:first_name => "first", :last_name => "last", :email => "facilitator@berkeley.edu",
  :password => "testingpass", :password_confirmation => "testingpass" }
  @user = User.create(@facilitator)
end

def create_other_facilitator
  @facilitator = {:first_name => "Kevin", :last_name => "Casey", :email => "overlord@berkeley.edu",
  :password => "testingpass", :password_confirmation => "testingpass" }
  @user = User.create(@facilitator)
end



def find_user
  @user = User.where(:email => @visitor[:email]).first
end

def create_user
  create_visitor
  @user = User.create(@visitor)
end

def sign_up
  visit 'users/sign_up'
  fill_in "user_email", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  fill_in "user_password_confirmation", :with => @visitor[:password_confirmation]
  click_button "Sign up"
  find_user
end

def sign_in
  visit 'users/sign_in'
  fill_in "user_email", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  click_button "Sign in"
end

def sign_in_non_facilitator
  visit 'users/sign_in'
  fill_in "user_email", :with => @non_facilitator[:email]
  fill_in "user_password", :with => @non_facilitator[:password]
  click_button "Sign in"
end

def sign_in_facilitator
  visit 'users/sign_in'
  fill_in "user_email", :with => @facilitator[:email]
  fill_in "user_password", :with => @facilitator[:password]
  click_button "Sign in"
end



### GIVEN ###

Given /^I am logged in$/ do
  create_user
  sign_in
end

Given /^I exist as a user$/ do
  create_user
end

Given /^I do not exist as a user$/ do
  create_visitor
end

Given /^I log out$/ do
  current_driver = Capybara.current_driver
  begin
    Capybara.current_driver = :rack_test
    page.driver.submit :delete, "/users/sign_out", {}
  ensure
    Capybara.current_driver = current_driver
  end
end

### WHEN ###

When /^I sign in as a non facilitator$/ do
  create_non_facilitator
  sign_in_non_facilitator
end

When /^I sign in as a facilitator$/ do
  create_facilitator
  sign_in_facilitator
end

When /^I sign in as another facilitator$/ do
  create_other_facilitator
  sign_in_facilitator
end


When /^I sign in as a user$/ do
  create_user
  sign_in
end

When /^I sign in with valid credentials$/ do
  create_visitor
  sign_in
end


When /^I sign up with valid user data$/ do
  create_visitor
  sign_up
end

When /^I sign up with an invalid email$/ do
  create_visitor
  @visitor = @visitor.merge(:email => "notanemail")
  sign_up
end

When /^I sign up without a password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "")
  sign_up
end

When /^I sign up without a password$/ do
  create_visitor
  @visitor = @visitor.merge(:password => "")
  sign_up
end

When /^I sign up with a mismatched password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "changeme123")
  sign_up
end

When /^I return to the site$/ do
  visit '/'
end

When /^I return to the home page$/ do
  visit '/'
end

When /^I sign in with a wrong email$/ do
  @visitor = @visitor.merge(:email => "wrong@example.com")
  sign_in
end

When /^I sign in with a wrong password$/ do
  @visitor = @visitor.merge(:password => "wrongpass")
  sign_in
end

When /^I edit my account details$/ do
  click_link "Edit profile"
  fill_in "user_class_level", :with => @visitor[:class_level]
  click_button "Update"
end

When /^I look at the list of users$/ do
  visit '/'
end

### THEN ###


Then /^I should be signed in$/ do
  page.should have_content "Logout"
  page.should_not have_content "Sign up"
  page.should_not have_content "Log in"
end

Then /^I should be signed out$/ do
  page.should have_link "SIGNUP"
  page.should have_link "SIGNIN"
  page.should_not have_content "Logout"
end

Then /^I see an unconfirmed account message$/ do
  page.should have_content "You have to confirm your account before continuing."
end

Then /^I see a successful sign in message$/ do
  page.should have_content "Signed in successfully."
end

Then /^I should see a successful sign up message$/ do
  page.should have_content "Welcome! You have signed up successfully."
end

Then /^I should see an invalid email message$/ do
  page.should have_content "Email is invalid"
end

Then /^I should see a missing password message$/ do
  page.should have_content "Password can't be blank"
end

Then /^I should see a missing password confirmation message$/ do
  page.should have_content "Password doesn't match confirmation"
end

Then /^I should see a mismatched password message$/ do
  page.should have_content "Password doesn't match confirmation"
end

Then /^I should see a signed out message$/ do
  page.should have_content "Signed out successfully."
end

Then /^I see an invalid login message$/ do
  page.should have_content "Invalid email or password."
end

Then /^I should see an account edited message$/ do
  page.should have_content "Your account has been updated successfully."
end

Then /^I should see my name$/ do
  create_user
  page.should have_content @user[:name]
end


