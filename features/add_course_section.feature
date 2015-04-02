Feature: Add New Section to Course
	As a facilitator
	So my course can have a section
	I want to add a section to my course

Background: facilitator has logged in

	Given the following users exist:
    | profile_id | email                      | name           | password     | 
    | 1          | markmiyashita@berkeley.edu | Mark Miyashita | ilovepython  | 
    | 2          | yunpark@berkeley.edu       | Yun Park       | iheartpython | 

    Given I am logged in as "yunpark@berkeley.edu" with password "iheartpython"
    Then I should be on my account page
	Then I press "Python on Crack"

Scenario: Successfully add section
	When I am on the course overview page
	And I press on “Add Section”
	Then I should be on the add section page
	When I fill in “section_title” with “Section 1”
	And I fill “ccn_ld” with “123456”
	And I fill “ccn_ud” with “234567”
	And I select the following ccn_visibility: No
	And I fill in “class_size” with "20"
	And I select the following status: Full
	And I fill in “first_day” with “11-29-2015”
	And I fill in “location” with “TBA”
	And I check the following days_of_week: Tuesday, Thursday
	And I select the following time_from: 5PM
	And I select the following time_to: 8PM
	And I check the following facilitators: Mark Miyashita, Yun Park
	And I press "Add Section"
	Then I should be on the course overview page
	And I should see "Section 1"