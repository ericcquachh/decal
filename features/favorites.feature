#Felix Liu
Feature: User can favorite a class
	As a User
	I want to be able to favorite a class

Background: User has logged in
	Given I sign in as a user
	And I visit the courses page
	Then I should see courses

Scenario: User successfully favorites a class
	Given I am on the courses page
	And I see a particular course
	And I click "favorite" button
	Then I visit my "dashboard"
	I should see the particular course in favorites
	I should not see other courses in favorites

Scenario: User successfully favorites a class in courses
	Given I am on a course page
	And I click "favorite" button
	Then I visit my "dashboard"
	I should see the particular course in favorites
	I should not see other courses in favorites

Scenario: Not Logged User should cannot favorite
	Given I am on the courses page
	And I click "logout"
	I should not see the "favorite" button
	Then I visit "dashboard"
	I should not see any courses in favorites