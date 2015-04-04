Feature: Add Files to Course
	As a facilitator of a course
	So students can view the course syllabus
	I want to add a file to my course

Background: facilitator has logged in
	When I sign in as a facilitator
	And I create a course
	
Scenario: Successfully add file
	Given I am on the course page for my course
	When I press "New Upload"
	Then I should be on the add file page
	When I add a file called "syllabus.pdf"
	And I press "Upload"
	Then I should be on the course page for "Python on Crack"
	And I should see "syllabus.pdf"

Scenario: Facilitators can't add files to courses they don't own
	Given I am on the facilitate page
	And another facilitator has created a course
	Then I should not see that course
	Given I am on the course page for that course
	Then I should not see "New Upload"

Scenario: Users can't add file
	Given I am on the courses page
	And I press "demote"
	Given I am on the course page for my course
	When I press "New Upload"
	Then I should not see "New Upload"


