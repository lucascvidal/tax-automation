Feature: Fill taxes in Brazilian Government System
  Nobody wants trouble with taxes

  Scenario: Tax and Revenue are filled successfully
    Given I'm at the login page
    When I log in with my credentials
    And I prepare the transactions details data
    Then I fill in the payment information
    And I fill in the dividend information
    Then All transactions are inputted into the system
