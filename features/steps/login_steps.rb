include AuthenticatedSystem

Then /^the page should have the "(.*)" link to "(.*)"$/ do |linkname, page|
  response.should have_tag("a[href=?]", page, linkname)
end

Then /^the page should have "(.*)" field$/ do |fieldname|
  response.should have_tag("input[id=?][name=?]",fieldname, fieldname)
end

Given /^that user "(.*)" has password "(.*)"$/ do |login, password|
  citizen = Citizen.new :login => login, :password => password, :password_confirmation => password, :email => "valid@email.com"
  citizen.save!
  citizen.activate!
end

Then /^I should be logged in$/ do
  logged_in?.should be_true
end
