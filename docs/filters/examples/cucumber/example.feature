Feature: Search
  In order to look up information
  I need to use the search option

  Scenario: Search for Abc
    Given that I am on the search page
    When I search for Abc
    Then I should see results for Abc


