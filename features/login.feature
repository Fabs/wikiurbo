Feature: Login into the Wikiurbo
	As a citizen not yet logged in
	I want to login
	So that I can acess my page and relative info
	
	Scenario: User see the links to login/signup at index
		Given that citizen is not logged in
		When I acess the page /
		Then the page should have the "Login" link to "/login"
		And the page should have the "Signup" link to "/signup"
		
	
	Scenario: User goes to the login page
		GivenScenario User see the links to login/signup at index
		When I follow "login"
		Then I should see "Login"
		And the page should have "login" field
		And I should see "Password"
		And the page should have "password" field
		And the page should have the "Signup" link to "/signup"
		
	Scenario: User fill the login form correctly and try to login
		GivenScenario User goes to the login page
		Given that user "schouery" has password "123456"
		When I fill in "login" with "schouery"
		And I fill in "password" with "123456"
		And I press "Log In"
		Then I should be logged in
		