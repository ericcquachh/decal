#Julian Wong
Feature: Courses should have Semesters and be filtered by semester
    As a user
    So that I can view relevant courses
    I want to able to see courses filtered by semester

Background: User has logged in
    Given I sign in as a user
    And the following courses exist:
    | Semester  | Title | Units | Category  | Pending | Status |
    | Fall 2016 | XYZ   | 2     | Business  | false   | Open   |
    | May 2015  | Teach | 3     | Languages | false   | Full   |
    | Fall 2016 | ABC   | 2     | Business  | false   | Open   |
    | Fall 2015 | FRE   | 2     | Business  | false   | Open   |
    And I am on the home page

Scenario: User can see all current semester courses
    Given I select 'Fall 2016'
    Then I should see 'XYZ'
    And I should see 'ABC'
    When I select 'Fall 2015'
    Then I should see 'FRE'

Scenario: Users cannot see non-semester courses
    Given I select 'Fall 2016'
    Then I should not see 'Teach'
    And I should not see 'FRE'
    When I select 'Fall 2015'
    Then I should not see 'XYZ'
    And I should not see 'Teach'
    And I should not see 'ABC'
