Feature: Facilitator should be able to approve or reject existing course co-facilitate requests
  As a facilitator
  In order to decide who can co-facilitate existing courses
  I want to approve and reject course facilitate requests

Background:
  Given I am signed in as a facilitator "afox@berkeley.edu"
  And these courses exist:
    | Title       | Category         | Units | Status | Facilitators            |
    | XYZ         | Business         | 2     | Open   | afox@berkeley.edu       |
    | Can't Teach | Computer Science | 3     | Full   | kevincasey@berkeley.edu |
  And these facilitate requests exist:
    | Title       | Requester                |
    | XYZ         | denero@berkeley.edu      |
    | XYZ         | imposter@berkeley.edu    |
    | Can’t Teach | shouldntsee@berkeley.edu |

Scenario:
  Given I am on the course page for "XYZ"
  Then I should see a facilitate request from "denero@berkeley.edu"
  And I should see a facilitate request from "imposter@berkeley.edu"
  And I should not see a facilitate request from "shouldntsee@berkeley.edu"
  When I approve the facilitate request from "denero@berkeley.edu"
  And reject the facilitate request from "imposter@berkeley.edu"
  Then "denero@berkeley.edu" should be a facilitator for "XYZ"
  And "imposter@berkeley.edu" should not be a facilitator for "XYZ"
  And these facilitate requests should not exist:
    | Title | Requester             |
    | XYZ   | denero@berkeley.edu   |
    | XYZ   | imposter@berkeley.edu |

