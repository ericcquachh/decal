Feature: Admin should be able to approve pending courses

As an admin
In order to approve new courses
I want to review and approve the course

Background: Admin has logged in
	When I sign in as an admin
	Given these courses exist:
	| Title         | Units | Category  | Pending  | Status | Department_num | Course_email | Faculty_email | Faculty_name |
	| test course   | 2  | Business  | true     | Open   | 5  | j | 123@gmail.com | Liza|
	| test course 2 | 3  | Entertainment  | true     | Open   | 5  | j | 123@gmail.com | Liza|

Scenario: Successfully approve a course
	When I visit the admin page
	And I press pending courses
	Then I should see "test course"
	Then I should seee "test course 2"
	Given I check "test course"
	And I press "Approve Course(s)"
	Then I visit home page
	And I should see "test course"
	When I vist the admin page
	And I press pending courses
	Then I should not see "test course"

Scenario: Non-Admin cannot add a course
	When I logout
	And I log in as a non-admin facilitator
	Then I should not see "Admin"
