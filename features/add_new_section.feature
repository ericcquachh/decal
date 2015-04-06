Feature: Add New Section
  As a facilitator
  So my course can have a section
  I want to add a section to my course

Background: facilitator has logged

  When I sign in as a facilitator

  Given these courses exist:
    | Title         | Category         | Units | Status |
    | Not My Course | Business         | 2     | Open   |
    | Can't Teach   | Computer Science | 3     | Full   |

Scenario: Successfully add section to courses I own
  Given I create a course
  Then my course should exist in home page
  Then I visit facilitate course page
  Then I create a new section
  Then I should see my new section in facilitate course page

Scenario: Fail to add section to course I don't own
  Then I visit facilitate course page
  When I click on "Not My Course" course
  Then I should not see "Add Section" button  

