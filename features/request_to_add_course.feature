Feature: Request to Add Course
  As a user
  In order to be approved as a facilitator for a course
  I want to submit a request approval form

Background: user has logged in
  When I sign in as a user

Scenario: User successfully submits request approval form
  Given I visit the facilitate page
  When I follow “Request to Add New Course”
  Then I should see the request form
  When I fill in the following:
    | Title                 | My First Course                |
    | Units                 | 2                              |
    | Department            | Haas                           |
    | Category              | Business                       |
    | Description           | Super cool class               |
    | Enrollment Info       | First come first serve yo      |
    | Course Contact Email  | coolbeans@berkeley.edu         |
    | Course Website        | www.coolcourse.com             |
    | Faculty Sponsor Name  | Frank Schultz                  |
    | Faculty Sponsor Email | frankschultz@haas.berkeley.edu |
  And I attach the file “course_syllabus” to the syllabus section
  And I press “Submit Request”
  Then I should see “Course request successfully submitted to admin.”

Scenario: User submits invalid form
  Given I visit the facilitate page
  When I follow “Request to Add New Course”
  And I fill in invalid fields
  And I press “Submit Request”
  Then I should see “Invalid fields”

Scenario: User submits incomplete form
  Given I visit the facilitate page
  When I follow “Request to Add New Course”
  And I fill in incomplete fields
  And I press “Submit Request”
  Then I should see “The following fields are required”
      
Scenario: Logged out user cannot submit form
  Given I log out
  And I visit the course homepage
  Then I should not see “Request to Add New Course”
