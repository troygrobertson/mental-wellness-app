Feature: viewing a patients properties
  Scenario: a doctor views his patient
    Given a Doctor is logged in
    And a Patient exists
    And the Doctor has a patient
    When they view the patient
    Then they should be on the patients page
    And a Patient is being logged
    And a log entry with the action viewed profile should be generated

  Scenario: a patient views themselves
    Given a Patient is logged in
    When they view themselves
    Then they should see their profile page

  Scenario Outline: only permitted users should be able to see a patients information
   Given an <role> is logged in 
   And a Patient exists
   When they view the patient
   Then they should get an error message
    Examples:
      |role|
      |Admin|
      |Doctor|
      |Patient|
