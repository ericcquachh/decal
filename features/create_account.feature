Feature: Create an account

	As a student
	So I can favorite a course
	I want to create an account

Background: student has not made an account

	Given PENDING: I am on the login page

Scenario: Successfully create an account

	Then I press "Create An Account"
	And I fill “first_name” with “Mark"
	And I fill "last_name" with "Miyashita"
	And I fill "password" with "ilikepython"
	And I fill "email" with "markmiyashita@berkeley.edu"
	And I select the following class_level: Senior
	And I press "Create Account"
	Then I should be on my account page
	And I should see "markmiyashita@berkeley.edu"