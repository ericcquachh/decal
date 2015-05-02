Feature: Request to Add Course
  As a user
  In order to be approved as a facilitator for a course
  I want to submit a request approval form

Background: user has logged in
  Given I sign in as a user
  And I visit facilitate course page
  Then I should see "Create a Course"
  When I follow "submit_course_for_approval"
  Then I should see "NEW COURSE"

Scenario: User successfully submits valid request course approval form
  Given I submitted a new course request form with valid fields
  And I upload valid CPF and syllabus files to my course
  Then I should see "has been uploaded and overwritten"

Scenario: Logged out user cannot submit form
  Given I log out
  Then I should see "Signed out successfully"
  When I visit facilitate course page
  Then I should redirect to login
