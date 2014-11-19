Feature: Offer Wall

  As an advertiser
  I want to retrieve offers
  So I can show them to users

  Scenario: Retrieving offers
    Given there are some offers
    When I submit a request
    Then the fyber API should be queried
    And I should see the offers

  Scenario: No offers available
    Given there are no offers
    When I submit a request
    Then the fyber API should be queried
    And I should see that there are no offers
