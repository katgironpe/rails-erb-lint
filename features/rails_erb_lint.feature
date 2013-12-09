Feature: Check validity of Rails ERB view files
  In order for an app to work properly
  I want to make sure all ERB views are valid

  Scenario: When help option is called
    When I get help for "rails-erb-lint"
    Then the exit status should be 0
    And the output should contain "A simple lint tool for ERB Rails views"

  Scenario: Wheck check_validity option is called on invalid views without arguments
    When I check validity of ERB files in "app/views/*.erb"
    Then the output should contain "invalid"
