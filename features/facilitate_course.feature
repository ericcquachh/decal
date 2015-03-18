Feature: Become a Facilitator for Existing Course
	As a facilitator
	So I can edit an existing course
	I want to become a facilitator for an existing course

Background:

	Given the following users exist:
    | profile_id | email                      | name           | password     | 
    | 1          | markmiyashita@berkeley.edu | Mark Miyashita | ilovepython  | 
    | 2          | yunpark@berkeley.edu       | Yun Park       | iheartpython | 

Scenario: 
  	When I am on the login page
  	Then I am log in as "yunpark@berkeley.edu" with pass "iheartpython"
  	Then I should be on My Account Page
  	Then I should press "Facilitate A Course"
  	Then I should press "Facilitate an Existing Course"
  	Then I should select from course_title: "Python On Crack"
  	Then I press "Facilitate Course"
  	Then I should be on Courses Facilitated page
  	And I should see "Python on Crack"