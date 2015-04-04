Feature: Add New Course
 	As a facilitator
 	So I can facilitate a new course
 	I want to be able to add a new course

Background: facilitator has logged

  When I sign in as a facilitator

Scenario: Facilitator successfully add valid course
  Given I create a course
  Then my course should exist in home page

Scenario: Facilitator adds a course without valid input
  Given I create a course with invalid fields
  Then the page should have an error
  Then I return to the home page
  Then my course should not exist in home page
  

Scenario: Non-facilitator cannot add course
  Given I return to the home page
  Then I log out
  Then I should see a signed out message
  When I sign in as a non facilitator
  Then page should not have add course button

