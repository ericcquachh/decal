Feature: Current user request to co-facilitate existing course
  As a user
  In order to become a co-facilitator for an existing course
  I want to submit requests to facilitate an existing course

Background:
  When I sign in as a user
  And these courses exist:
    | Title       | Category         | Units | Status | Facilitators            |
    | XYZ         | Business         | 2     | Open   | afox@berkeley.edu       |
    | Can't Teach | Computer Science | 3     | Full   | kevincasey@berkeley.edu |

Scenario:
  Given I am on the course page for “XYZ”
  When I request to facilitate “XYZ”
  And I have a valid number of facilitate requests
  Then I should see a successful confirmation for the facilitate request

Scenario:
  Given I am on the course page for “XYZ”
  And I already have a facilitate request for “XYZ”
  When I request to facilitate “XYZ”
  Then I should see an unsuccessful notice for the facilitate request

Scenario:
  Given I am on the course page for “XYZ”
  And I have an invalid number of facilitate requests
  When I request to facilitate “XYZ”
  Then the facilitate request for “XYZ” should fail
  And I should see an unsuccessful notice for the facilitate request
