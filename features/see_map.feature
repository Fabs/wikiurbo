Feature: Viewing the map
  	As a user acessing the site
	I want to see a map
	So that I can acess the relative info from the places
  
  Scenario: Show a map at index page
	When I acess the page /
    Then the page should have tag div#map_div
	And the page should include the headers for the map
	