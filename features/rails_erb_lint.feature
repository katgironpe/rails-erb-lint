Feature: Check validity of Rails ERB view files
  In order for an app to work properly
  I want to make sure all ERB views are valid

  Scenario: When help option is called
    When I get help for "rails-erb-lint"
    Then the exit status should be 0
    And the output should contain "A simple lint tool for ERB Rails views"

  Scenario: Wheck check_validity option is called on valid views without arguments
    Given I have only valid ERB files
    When I check validity of ERB files in current directory
    Then the output should contain "Checking for files in current directory"
    And the output should contain "1 files, no invalid file"
    And the exit status should be 0

  Scenario: Wheck check_validity option is called on invalid views without arguments
    Given I have invalid ERB files
    When I check validity of ERB files in current directory
    Then the output should contain "Checking for files in current directory"
    And the output should contain "1 invalid file"
    And the output should not contain "valid.erb => valid"
    And the exit status should be 1

  Scenario: Wheck check_validity option is called on invalid views with the -v switch
    Given I have invalid ERB files
    When I check validity of ERB files in current directory with -v switch
    Then the output should contain "Checking for files in current directory"
    And the output should contain "1 invalid file"
    And the output should contain "valid.erb => valid"
    And the exit status should be 1
