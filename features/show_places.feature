Feature: Creating Places
	As a user
	I want to create a new place
	So I can record information about it
							
	Scenario: User logged in creates a place
		Given that I am logged in
		And that I am at page "/places/new"
		When I fill in "Name" with "Brazil"
		And I press "submit"
		Then I should see "Brazil"
		And the coordinates should be lat -14.235004 and lang -51.92528

	Scenario: User not logged in can't create place
	 	Given that I am not logged in
		And that I am at page "/places/new"
		Then I should not be able to create the place
	
	Scenario: User logged in access a place that exists but wants to create a new one
		Given that Place 1 exists
		And that I am at page "/places/1"
		When I follow "Create subplace"
		Then I should see a create place page
		And it should know what is the parent place
	