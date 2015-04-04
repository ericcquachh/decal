Feature: Add New Course
 	As a facilitator
 	So I can facilitate a new course
 	I want to be able to add a new course

Background: facilitator has logged

  When I sign in as a facilitator

Scenario: Facilitator successfully add valid course
  Given I create a course
  Then my course should exist in home page

Scenario: Facilitator cannot add course with invalid course info
  

Scenario: Non-facilitator cannot add course

