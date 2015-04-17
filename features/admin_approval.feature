Feature: Admin should be able to approve pending courses

As an admin
In order to approve new courses
I want to review and approve the course

Background: Admin has logged in
	When I sign in as an admin
	Given that the following courses are added:
	| Title         | Units | Department | Category      | Email           | Approved |
	| test course   | 2     | UGBA       | Business      | test@gmail.com  | false    |
	| test course 2 | 3     | CS         | Entertainment | test2@gmail.com | false    |

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
