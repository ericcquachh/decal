Feature: Add Files to Course
	As a facilitator of a course
	So students can view the course syllabus
	I want to add a file to my course

Background: facilitator has logged in
	When I sign in as a facilitator
	And I create a course
	
Scenario: Successfully add file
	Given I am on the facilitate page
	Given I am on the course page for "Python on Crack"
	Then I should see "New Upload"
	When I press "New Upload"
	Then I should be on the add file page
	When I add a file called "syllabus.pdf"
	And I press "Upload"
	Then I should be on the course page for "Python on Crack"
	And I should see "syllabus.pdf"

Scenario: Facilitators can't add files to courses they don't own
	Given I am on the facilitate page
	And I own "Python on Crack"
	And I don't own "Ruby on Rails"
	Then I should not see "Ruby on Rails"
	Given I am on the course page for "Ruby on Rails"
	Then I should not see "New Upload"

Scenario: Users can't add file
	Given I am on the courses page
	And I press "Demote"
	Given I am on the course page for "Python on Crack"
	Then I should not see "New Upload"


