Feature: Adding cofacilitator
	As a facilitator
	I want to be able to add other students
	So that they can also be cofacilitators for my course

Background: Facilitator has logged in
	Given I sign in as a user
	And the following users exist:
		| email                      | first name | last name | password    |
		| jetli@berkeley.edu         | jet        | li        | 12345678    |
		| pierceoeflein@berkeley.edu | pierce     | oeflein   | 12345678    |
	When I visit facilitate course page
	And I follow "submit_course_for_approval"
	And I submitted a new course request form with valid fields
	And my course "Test Course" is approved

Scenario: Facilitator can search and approve a student
	Given I visit facilitate course page
	And I click on "Test Course" course
	When I add facilitators for my course
	And I search for "jet"
	And I check "jetli@berkeley.edu"
	And I press "add_these_facilitators"
	Then I should see "jetli@berkeley.edu"

Scenario: Facilitator should not find a non-existent student
	Given I visit facilitate course page
	And I click on "Test Course" course
	When I add facilitators for my course
	And I search for "sdgs"
	Then I should not see "sdgs@berkeley.edu"
