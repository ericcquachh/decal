Feature: Admin should be able to approve pending courses

As an admin
In order to approve new courses
I want to review and approve the course

Background: Admin has logged in
	When I sign in as an admin
	Given these courses exist:
	| Title | Units | Category  | Pending  | Dep Num | Faculty Email  | Faculty Name |
	| XYZ   | 2     | Business  | true     | UGBA 9  | a@berkeley.edu | Prof A       |
	| Teach | 3     | Languages | true     | LING 4  | b@berkeley.edu | Prof B       |

Scenario: Successfully approve a course
	When I visit the admin page
	And I follow "pending_courses"
	Then I should see "Business"
	And I should see "Languages"
	And I should see "No Syllabus Uploaded!"
	Given I check "course_ids_1"
	And I press "approve_courses"
        And I follow "approved_courses"
        Then I should be able to see the link "XYZ"
        And I should not be able to see the link "Teach"

Scenario: Non-admin cannot approve a course
	When I log out
	And I sign in as a user
	And I visit the admin page
	Then I should see "You do not have admin priveleges"
