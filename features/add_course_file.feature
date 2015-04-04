Feature: Add Files to Course
	As a facilitator of a course
	So students can view the course syllabus
	I want to add a file to my course

Background: facilitator has logged in
	When I sign in as a facilitator
	And I create a course
	
Scenario: Successfully add file
	Given I am on the course page for my course
	Then I should see a "New Upload" button
	When I press "New Upload"
	Then I should be on the add file page for my course
	When I upload a file called "test.pdf"
	Then I should be on the course page for my course
	And I should see "test.pdf"

Scenario: Facilitators can't add files to courses they don't own
	Given another facilitator has created a course
	And I am on the facilitate page
	Then I should not see that course
	Given I am on the course page for that course
	Then I should not see "New Upload"

Scenario: Users can't add file
	Given I am on the courses page
	And I press "demote"
	Given I am on the course page for my course
	Then I should not see a "New Upload" button


