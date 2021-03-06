#Julian

def create_admin
  @admin = { :admin=>true, :first_name => "Kevin", :last_name => "Casey", :email => "overlord@berkeley.edu",
  :password => "testingpass", :password_confirmation => "testingpass" }
  @user = User.create(@admin)
end

def sign_in_admin
  visit 'users/sign_in'
  fill_in "user_email", :with => @admin[:email]
  fill_in "user_password", :with => @admin[:password]
  click_button "Sign in"
end

When /^I sign in as an admin$/ do
  create_admin
  sign_in_admin
end

When /^I visit the admin page$/ do
  visit '/admin'
end

When /^I visit the home page/ do
  visit '/'
end
