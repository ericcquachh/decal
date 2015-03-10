Feature: display list of courses sorted by different criteria

  As a student
  So that I can decide what courses to enroll in
  I want to see courses sorted by title

Background: movies have been added to database

  Given the following movies exist:
  | title                    | category           | units | time            | status |
  | Quantum Consciousness    | Cognitive Science  | 2-3   | TuTh 5PM-6PM    | open   |
  | Taiwanese Language       | Languages          | 1-2   | MW 5PM-6:30PM   | full   |
  | Python on Crack          | Computer Science   | 3     | MWF 6PM-8PM     | full   |
  | Ruby on Rails            | Computer Science   | 2     | MW 7PM-8PM      | full   |
  | Max Interval Training    | Fitness            | 1     | W 8PM-9PM       | open   |
  | Introduction to Banking  | Business           | 2     | TuTh 6PM-7PM    | full   |

  And I am on the Decal courses page

Scenario: sort title alphabetically
  When I follow "Course Title"
  Then I should see "Introduction to Banking" before "Python on Crack"
