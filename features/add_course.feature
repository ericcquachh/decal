Feature: Add New Course
 	As a DeCal facilitator
 	So I can create a Decal
 	I want to be able to add a DeCal course

Background:

	Given the following users exist:
    | profile_id | email                      | name           | password     | 
    | 1          | markmiyashita@berkeley.edu | Mark Miyashita | ilovepython  | 


  Scenario: Successfully add course
  	When I am on the login page
  	Then I am log in as "markmiyashita@berkeley.edu" with pass "ilovepython"
  	Then I should be on My Account Page
  	Then I should press "Facilitate a Course"
  	Then I should be on the Courses Facilitated page
  	Then I should press "Facilitate a New Course"
	Then I should be on the add new course page
	And I fill in "course_title" with "Python on Crack"
	And I fill in “course_department_number” with “CS 198”
	And I select from semesters: Fall 2015
	And I fill in “category” with “Computer Science”
	And I fill in "course_description" with "Lorem Ipsum"
	And I fill in “enrollment_info” with “Lorem Ipsum”
	And I fill in “course_contact_email” with “pythononcrack@gmail.com”
	And I fill in “course_website” with “http://www.pythononcrack.com”
	And I fill in “faculty_sponsor” with “John Denero”
	And I fill in “faculty_sponsor_email” with “JohnDenero@berkeley.edu”
	And I press "Add Course"
	Then I should be on the Courses Facilitated page
	Then I should see "Python on Crack"
	When I follow "Python on Crack"
	Then I should see "Lorem Ipsum"