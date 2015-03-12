Feature: display list of courses filtered by title
 
  As a student
  So that I can decide what courses to enroll in
  I want to see courses matching only from certain title

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

Scenario: restrict to title containing 'Python' in title
  When I search the following title: Python
  And I press "Search"
  Then I should see "Python on Crack"
  And I should not see "Ruby on Rails"
