Feature: Add Files to Course
	As a facilitator of a course
	So students can view the course syllabus
	I want to add a file to my course

Background: user has logged in
	Given the following users exist:
    | profile_id | email                      | name           | password     | 
    | 1          | markmiyashita@berkeley.edu | Mark Miyashita | ilovepython  | 
    | 2          | yunpark@berkeley.edu       | Yun Park       | iheartpython | 

	When I am on the login page
    And I log in as "yunpark@berkeley.edu" with password "iheartpython"
    And I promote myself to a facilitator
	

Scenario: Successfully add file
	Given I am on my facilitate page
	And I own "Python on Crack"
	Given I am on the course page for "Python on Crack"
	Then I should see "New Upload"
	When I press "New Upload" button
	Then I should be on the add file page
	When I add a file called "syllabus.pdf"
	And I press "Upload"
	Then I should be on the course page for "Python on Crack"
	And I should see "syllabus.pdf"

Scenario: Users can't add file
	Given I am on the courses page
	And I demote myself to a user
	Given I am on the course page for "Python on Crack"
	Then I should not see "New Upload"

Scenario: Facilitators can't add files to courses they don't own
	Given I am on my facilitate page
	And I own "Python on Crack"
	And I don't own "Ruby on Rails"
	Then I should not see "Ruby on Rails"
	Given I am on the course page for "Ruby on Rails"
	Then I should not see "New Upload"

