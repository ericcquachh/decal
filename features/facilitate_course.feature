Feature: Facilitate an Existing Course
	As a facilitator
	So I can edit an existing course
	I want to become a facilitator for that existing course

Background: facilitator has logged in

	Given the following users exist:
    | email                      | first name | last name | password     | 
    | markmiyashita@berkeley.edu | Mark       | Miyashita | ilovepython  | 
    | yunpark@berkeley.edu       | Yun        | Park      | iheartpython | 

    When I am logged in as Yun Park
    Then I should see the course page

Scenario: 
  	Given I am on my account page
  	Then I should press "Facilitate an Existing Course"
  	Then I should select from course_title: Python On Crack
  	Then I should select from semester: Fall 2015
  	Then I press "Facilitate Course"
  	Then I should be on my account page
  	And I should see "Python on Crack"
