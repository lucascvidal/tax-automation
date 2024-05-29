Feature: File Complaint in KPMG Treinamento Organization
  Everybody wants to file a complaint

  Scenario: Complaint filing is successful
    Given I am on the complaint filing page
    When I enter valid complaint details
    Then I should file a complaint successfully