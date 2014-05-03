When /^I get help for "([^"]*)"$/ do |app_name|
  @app_name = app_name
  step %(I run `#{app_name} help`)
end

When /^I go to views directory$/ do
  path = "#{Dir.pwd}/features/fixtures/app/views"
  step %(I run `cd #{path}`)
end

Then /^I check validity of ERB files in current directory$/ do
  step %(I run `rails-erb-lint check`)
end

Then /^the output should contain ([^"]*)"$/ do |output|
  assert_matching_output(output)
end
