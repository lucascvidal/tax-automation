Feature: Fill taxes in Brazilian Government System
  Nobody wants trouble with taxes

  Scenario: Tax and Revenue are filled successfully
    Given I'm at the login page
    When I log in with my credentials
    And I browse to the revenue and tax input page
    And I fill my taxes and revenue
    Then I submit the form
