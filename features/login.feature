Feature: Login into the Wikiurbo
	As a citizen not yet logged in
	I want to login
	So that I can acess my page and relative info
	
	Scenario: User goes to the login page
		Given that citizen is not logged in
		When I acess the page /
		Then the page should have the login link to "/login"
		When I follow "login"
		Then the page should have email field
		And the page should have password field
