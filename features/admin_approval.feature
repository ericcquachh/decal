Feature: Admin should be able to approve pending courses

As an admin
In order to approve new courses
I want to review and approve the course

Background: Admin has logged in
	When I sign in as an admin
	Given these courses exist:
	| Title | Units | Category  | Pending  | Status |
	| XYZ   | 2     | Business  | true     | Open   |
	| Teach | 3     | Languages | true     | Full   | 

Scenario: Successfully approve a course
	When I visit the admin page
	And I follow "pending_courses"
	Then I should see "XYZ"
	And I should see "Teach"
	Given I check "XYZ"
	And I press "approve_courses"
	Then I should not see "XYZ"
	And I should see "Teach"
	When I follow "approved_courses"
	Then I should see "XYZ"
	And I should not see "Teach"
	When I visit the home page
	Then I should see "XYZ"

Scenario: Non-admin cannot approve a course
	When I log out
	And I sign in as a user
	And I visit the admin page
	Then I should see "You do not have admin priviledges"
