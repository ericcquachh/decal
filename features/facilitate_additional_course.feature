Feature: Facilitate an Additional Existing Course
  As a facilitator
  So I can edit an additional existing course
  I want to become a facilitator for that existing course

Background: facilitator has logged in

  When I sign in as a facilitator
  Given these courses exist:
    | Title         | Category         | Units | Status |
    | Not My Course | Business         | 2     | Open   |
    | Can't Teach   | Computer Science | 3     | Full   |

Scenario: 
  Given I visit the course dashboard page
  When I follow "Facilitate Additional Course"
  Then I should see "Courses You Don't Facilitate"
  And I should see "Not My Course"
  And I should see "Can't Teach"
  When I check "Not_My_Course"
  And I press "Facilitate These Courses"
  Then I should see "Your Courses"
  And I should see "Not My Course"
