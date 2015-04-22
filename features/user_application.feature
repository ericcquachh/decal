# Brian Truong
Feature: Courses should have applications
Background: User has logged in
	Given I sign in as a user
	And the following courses exist:
	| Title | Units | Category  | Pending | Status |
	| XYZ   | 2     | Business  | true    | Open   |
	| Teach | 3     | Languages | true    | Full   |

Scenario: User can apply for course if status is open
	Given I click on "XYZ" course
	And the course status is open
	Then I should see "apply" button

Scenario: User cannot apply for course if status is full
	Given I click on "Teach" course
	And the course status is full
	Then I should not see "apply"
	And I should see "sorry the course is full!"

Scenario: User should not be able to apply for the same course multiple times
	Given I have applied to "XYZ"
	And I click on "XYZ" course
	Then I should not see "apply" button
	And I should see "application received"

Scenario: Course should show number of applications received
	Given I click on "XYZ" course
	And the course is open
	And the course has received "10" applications
	Then I should see "10 applications have been received"

Scenario: Course should show number of applications received (sad path)
	Given I click on "XYZ" course
	And the course is full
	And the course has received "50" applications
	Then I should not see "50 applications have been received"
	And I should see "sorry the course is full!"
