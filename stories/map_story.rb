require File.expand_path(File.dirname(__FILE__) + "/helper")

Story "Viewing the map and acessing the info", %{
  As a user acessing the site
  I want to see a map 
  So that I can access the relative info from the places
}, :type => RailsStory do
  
  Scenario "not logged in user see a map" do
    Given "user is not logged in" do
      pending "need to set session[:current_user] as nil"
    end
    
    When "citizen access the homepage" do
      get "/"
    end
    
    Then "the page should show", "div#map_div" do |tag|
      response.should have_tag(tag)
    end
    And "the page should include javascript for the map"
    And "the map should have the existent places"
  end
  
end