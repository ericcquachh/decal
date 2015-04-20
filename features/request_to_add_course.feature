Feature: Request to Add Course
  As a user
  In order to be approved as a facilitator for a course
  I want to submit a request approval form

Background: user has logged in
  Given I sign in as a user
  And I visit facilitate course page
  Then I should see "How to start a Course"
  When I follow "submit_course_for_approval"
  Then I should see "New course"

Scenario: User successfully submits valid request course approval form
  Given I submitted a new course request form with valid fields
  Then I should see "Course request successfully submitted to admin."

Scenario: User submits invalid form
  Given I input invalid fields in the new course request form
  And I press "continue"
  Then the page should have an error

Scenario: User submits incomplete form
  Given I leave incomplete fields in the new course request form
  And I press "continue"
  Then I should see "can't be blank"
      
Scenario: Logged out user cannot submit form
  Given I log out
  Then I should see "Signed out successfully"
  When I visit facilitate course page
  Then I should see "make sure you login"
