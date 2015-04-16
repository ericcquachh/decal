Feature: display list of courses filtered by time
  As a student
  So that I can decide what courses to enroll in
  I want to see courses matching only with certain times

Background: courses have been added to database

  Given the following courses exist:
  | id | title                   | category          | units | status |
  | 1  | Quantum Consciousness   | Cognitive Science | 2     | Open   |
  | 2  | Taiwanese Language      | Languages         | 1     | Full   |
  | 3  | Python on Crack         | Computer Science  | 3     | Full   |
  | 4  | Ruby on Rails           | Computer Science  | 2     | Full   |
  | 5  | Max Interval Training   | Fitness           | 1     | Open   |
  | 6  | Introduction to Banking | Business          | 2     | Full   |

  And the following sections exist:
    | id | course_id |
    | 1  | 1         |
    | 2  | 2         |
    | 3  | 3         |
    | 4  | 4         |
    | 5  | 5         |
    | 6  | 6         |

  And the following section_times exist:
    | id | section_id | days | start_time | end_time |
    | 1  | 1          | MW   | 5:00PM     | 6:00PM   |
    | 2  | 2          | MW   | 5:00PM     | 6:30PM   |
    | 3  | 3          | MWF  | 6:00PM     | 8:00PM   |
    | 4  | 4          | MW   | 7:00PM     | 8:00PM   |
    | 5  | 5          | W    | 8:00PM     | 9:00PM   |
    | 6  | 6          | TuTh | 6:00PM     | 7:00PM   |

  And I am on the Decal courses page
  And I set everything to default

Scenario: restrict to courses with "Tuesday" time
  When I check the following days_of_week: Tu
  And I press "Search"
  Then I should see "Quantum Consciousness"
  And I should see "Introduction to Banking"
  And I should not see "Max Interval Training"

Scenario: restrict to courses in between 5:00 pm and 6:00 pm
  When I select 5:00PM from "start_time"
  And I select 6:00PM from "end_time"
  And i press "Search"
  Then I should see "Quantum Consciousness"
  And I should see "Taiwanese Language"
  And I should not see "Python on Crack"

Scenario: New fields in create form
  When I go to the new course page
  Then I should see course description
  And I should see  course enrollment info

Scenario: Courses should have semester field
  Given that the following courses exist:
    | id | title | category         | units | status |
    | 7  | New   | Computer Science | 1     |        |
  When I visit the course homepage
  Then I should see
