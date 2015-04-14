Feature: Edit User
  As a user
  I want to edit my user profile
  so I can change my info

    Scenario: I sign in and edit my account
      Given I am logged in
      When I edit my account details
      Then I should see an account edited message
