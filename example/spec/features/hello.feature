Feature: Access

  Scenario: / (SUCCESS)
    When I am on the "/"
    Then I should see "Hello World"

  Scenario: / (FAILED)
    When I am on the "/"
    Then I should see "Hoge World"

  Scenario: /form (SUCCESS)
    When I am on the "/form"
     And type "Gongo" to "name"
     And click "Go!"
    Then I should see "Gongo"

  Scenario: /form (FAILED)
    When I am on the "/form"
     And type "Gongo" to "name"
     And click "Go!"
    Then I should see "Gengo"

  Scenario: /form (FAILED)
    When I am on the "/form"
     And type "Gongo" to "name"
     And click "Push"
    Then I should see "Gongo"

  @javascript
  Scenario: /confirm (SUCCESS) (confirm 'ok' using selenium)
    When I am on the "/confirm"
     And type "Gongo" to "name"
     And click "Go!"
     And "submit?" confirm is "ok"
    Then I should see "Gongo"

  @javascript
  Scenario: /confirm (SUCCESS) (confirm 'cancel' using selenium)
    When I am on the "/confirm"
     And type "Gongo" to "name"
     And click "Go!"
     And "submit?" confirm is "cancel"
    Then I should not see "Gongo"
     And typed "name" with "Gongo"

  @javascript
  Scenario: /confirm (FAILED) (confirm 'ok' using selenium)
    When I am on the "/confirm"
     And type "Gongo" to "name"
     And click "Go!"
     And "submit?" confirm is "ok"
    Then I should see "Gengo"

  @javascript
  Scenario: /confirm (FAILED) (confirm 'cancel' using selenium)
    When I am on the "/confirm"
     And type "Gongo" to "name"
     And click "Go!"
     And "submit?" confirm is "cancel"
    Then I should not see "Gongo"
     And typed "name" with "Gengo"
