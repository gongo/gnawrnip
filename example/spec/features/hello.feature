Feature: Access

  Scenario: / (Success)
    When I am on the "/"
    Then I should see "Hello World"

  Scenario: / (Failed...)
    When I am on the "/"
    Then I should see "Hoge World"

  Scenario: /form (Success)
    When I am on the "/form"
     And type "Gongo" to "name"
     And click "Go!"
    Then I should see "Gongo"

  Scenario: /form (Failed...)
    When I am on the "/form"
     And type "Gongo" to "name"
     And click "Go!"
    Then I should see "Gengo"

  Scenario: /form (Failed...)
    When I am on the "/form"
     And type "Gongo" to "name"
     And click "Push"
    Then I should see "Gongo"
