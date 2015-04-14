Feature: Admin should be able to manage a course
	As an admin
	In order to manage a course
	I should be able to view, edit, destroy a course

Background: Admin has logged in
	When I sign in as an admin
	Given that the following courses are :
	| Title         | Units | Department | Category      | Email           | Approved |
	| test course   | 2     | UGBA       | Business      | test@gmail.com  | true     |
	| test course 2 | 3     | CS         | Entertainment | test2@gmail.com | true     |

Scenario: Successfully edit a course I don't own
	When I visit the admin page
	And I press "Edit Courses"
	And I follow "test course"
	And I press "Edit"
	And I select "Arts" from "Category"
	And I press "Update Course"
	Then I follow "test course"
	Then I should see "Arts"

Scenario: Successfully destroy a course I don't own
	When I visit the admin page
	And I press "Edit Courses"
	And I follow "test course"
	And I press "Delete Course"
	Then I should not see "test course"
