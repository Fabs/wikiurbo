Feature: Creating Places
	As a user
	I want to create a new place
	So I can record information about it
							
	Scenario: User logged in creates a place
		Given I'm logged in
		And at page "/places/new"
		When I fill the form
		And hit submit
		Then I should see the show place page

	Scenario: User not logged in can't create place
	 	Given I'm not logged in
		And at page "/places/new"
		Then I should see "Please Login or Signup"
		And I should see "Login" link
		And I should see "Signup" link
	
	Scenario: User logged in access a place that exists but wants to create a new one
		Given that I'm at a show place page
		When I follow "Create subplace"
		Then I should see a create place page
		And it should know what is the parent place
	