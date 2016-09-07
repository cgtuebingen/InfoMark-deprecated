Feature: Page loads
  In order to use this page
  a visitor calls the login page
  and should be able to login

  Scenario: Open login page
    Given I am on the new user session page
    Then I should see "Anmelden"

  Scenario: wrong user
    Given I am on the new user session page
    And I fill in "user[email]" with "foo@bar.com"
    And I fill in "user[password]" with "topsecret"
    When I press "Login"
    Then I should see "Invalid email or password."

  Scenario: wrong email
    Given I am on the new user registration page
    And I fill in "user[email]" with "foo@bar.com"
    And I fill in "user[password]" with "topsecret"
    When I press "jetzt Registrieren"
    Then I should see "Email is invalid"

  Scenario: correct email
    Given I am on the new user registration page
    And I fill in "user[first_name]" with "Max"
    And I fill in "user[last_name]" with "Muster"
    And I fill in "user[email]" with "foo@uni-tuebingen.de"
    And I fill in "user[email]" with "foo@uni-tuebingen.de"
    And I fill in "user[password]" with "topsecret"
    And I fill in "user[password_confirmation]" with "topsecret"
    When I press "jetzt Registrieren"
    Then I should see "You need to sign in or sign up before continuing."
