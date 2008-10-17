When /I acess the page (.*)/ do |page|
  get page
end

Then /the page should have tag (.*)/ do |tag|
  response.should have_tag(tag)
end