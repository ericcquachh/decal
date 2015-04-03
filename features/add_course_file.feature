Feature: Add Files to Course
	As a facilitator
	So students can view the course syllabus
	I want to add a file to my course

Background: facilitator has logged in
	Given the following users exist:
    | profile_id | email                      | name           | password     | 
    | 1          | markmiyashita@berkeley.edu | Mark Miyashita | ilovepython  | 
    | 2          | yunpark@berkeley.edu       | Yun Park       | iheartpython | 

	When I am on the login page
    Then I am logged in as "yunpark@berkeley.edu" with password "iheartpython"
	Given I am on my account page
	Then I press "Python on Crack"

Scenario: Successfully add file
	Given I am on the course overview page
	And I press on "Upload"
	Then I should be on the add file page
	And I add a file called "syllabus.pdf"
	And I press "Upload"
	Then I should be on the course overview page
	And I should see "syllabus.pdf"