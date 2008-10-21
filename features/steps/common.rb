Given /^that I am not logged in$/ do
end

Given /^that I am at page "(.*)"$/ do |page|
  get page
end

When /^I acess the page (.*)$/ do |page|
  get page
end
