Given(/^I have invalid ERB files$/) do
  source = Dir['./features/fixtures/app/views/*']
  dest = Dir['./tmp/aruba']
  FileUtils.cp_r(source, dest)
end

When /^I get help for "([^"]*)"$/ do |app_name|
  @app_name = app_name
  step %(I run `#{app_name} help`)
end

Then /^I check validity of ERB files in current directory$/ do
  step %(I run `rails-erb-lint check`)
end

Then /^I check validity of ERB files in current directory with -v switch$/ do
  step %(I run `rails-erb-lint check --verbose`)
end

Then /^the output should contain ([^"]*)"$/ do |output|
  assert_matching_output(output)
end

Then /^the output should not contain ([^"]*)"$/ do |output|
  assert_not_matching_output(output)
end
