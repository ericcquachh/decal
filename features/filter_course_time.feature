Feature: display list of courses filtered by time
 
  As a student
  So that I can decide what courses to enroll in
  I want to see courses matching only with certain times

Background: courses have been added to database

  Given the following courses exist:
  | title                    | category           | units | time            | status |
  | Quantum Consciousness    | Cognitive Science  | 2-3   | TuTh 5PM-6PM    | open   |
  | Taiwanese Language       | Languages          | 1-2   | MW 5PM-6:30PM   | full   |
  | Python on Crack          | Computer Science   | 3     | MWF 6PM-8PM     | full   |
  | Ruby on Rails            | Computer Science   | 2     | MW 7PM-8PM      | full   |
  | Max Interval Training    | Fitness            | 1     | W 8PM-9PM       | open   |
  | Introduction to Banking  | Business           | 2     | TuTh 6PM-7PM    | full   |

  And I am on the Decal courses page

Scenario: restrict to title with "Tuesday" time
  When I select the following days of week: Tuesday
  And I press "Search
  Then I should see "Quantum Consciousness" 
  And I should see "Introduction to Banking"   

Scenario: restrict to title starting time "8PM" and ending time "9PM"
  When I select the following starting time: 8PM
  When I select the following ending time: 9PM
  And I press "Search"
  Then I should see "Max Interval Training" 
 
