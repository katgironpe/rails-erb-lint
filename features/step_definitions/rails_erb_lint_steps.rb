When /^I get help for "([^"]*)"$/ do |app_name|
  @app_name = app_name
  step %(I run `#{app_name} help`)
end

When(/^I check validity of ERB files in current directory$/) do
  step %(I run `rails-erb-lint check`)
end

Then /^the output should contain ([^"]*)"$/ do |output|
  assert_matching_output(output)
end
