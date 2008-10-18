Given /^that citizen is not logged in$/ do
end

Then /^the page should have the (.*) link to "(.*)"$/ do |linkname, page|
  response.should have_tag("a[href=?]", page, linkname)
end

# Then /^the page should have (.*) field$/ do |fieldname|
# end
