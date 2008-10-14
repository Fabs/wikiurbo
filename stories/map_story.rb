require File.expand_path(File.dirname(__FILE__) + "/helper")

Story "Viewing the map", %{
  As a citizen
  I want to see a map 
  So that I can access the relative info from the places
}, :type => RailsStory do
  
  Scenario "not logged in citizen" do
    Given "citizen is not logged in" do
      pending "need a way to know if a citizen is logged in"
    end
    
    When "citizen access the homepage" do
      pending "need a home controller"
    end
    
    Then "it should see a map" do
      pending "need a index for the home controller"
    end
  end
  
end