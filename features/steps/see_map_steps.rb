When /I acess the page (.*)/ do |page|
  get page
end

Then /the page should have tag (.*)/ do |tag|
  response.should have_tag(tag)
end

# Then /the page should include javascript for the map/ do
#   pending
# end
#     
# Then /the map should have the existent places/ do
#   pending
# end