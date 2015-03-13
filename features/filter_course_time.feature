Feature: display list of courses filtered by time
 
  As a student
  So that I can decide what courses to enroll in
  I want to see courses matching only with certain times

Background: courses have been added to database

  Given the following courses exist:
  | title                    | category           | units | time            | status |
  | Quantum Consciousness    | Cognitive Science  | 2     | TuTh 5PM-6PM    | Open   |
  | Taiwanese Language       | Languages          | 1     | MW 5PM-6:30PM   | Full   |
  | Python on Crack          | Computer Science   | 3     | MWF 6PM-8PM     | Full   |
  | Ruby on Rails            | Computer Science   | 2     | MW 7PM-8PM      | Full   |
  | Max Interval Training    | Fitness            | 1     | W 8PM-9PM       | Open   |
  | Introduction to Banking  | Business           | 2     | TuTh 6PM-7PM    | Full   |

  And I am on the Decal courses page
  And I set everything to default

Scenario: restrict to courses with "Tuesday" time
  When I check the following days_of_week: Tuesday
  And I press "Search"
  Then I should see "Quantum Consciousness" 
  And I should see "Introduction to Banking"   

Scenario: restrict to courses with starting time "8PM" and ending time "9PM"
  When I select the following starting_time: 8PM
  When I select the following ending_time: 9PM
  And I press "Search"
  Then I should see "Max Interval Training" 
 
