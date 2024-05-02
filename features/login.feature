Feature: Log into Numerix OneView
  Everybody wants to log in

  Scenario: Log in is successful
    Given I am on the login page
    When I enter my password and email
    Then I should be logged into OneView