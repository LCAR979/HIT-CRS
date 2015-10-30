#encoding: utf-8
Feature: Sign up
  In order to get access to the system
  A visitor
  Should goto signup page

  Scenario: Go to signup page
    Given I am on the index page
    And I click on signup button
    Then I will goto signup page

  Scenario: Submit the signup form
    Given I am on the signup page
    And I fill in username with Tiancheng
    And I fill in password with 123456
    And I fill in name with Someone Turing
    And I fill in phone with 15754601111
    And I fill in email with tcoperator@163.com
    And I choose student
    And I fill in studentid with hjkl123
    And I fill in department with Computer Science
    When I click "submit"
    Then I will goto index page
    
  Scenario: Go to login page
    Given I am on the index page
    And I click on login button
    Then I will goto login page

  Scenario: Login
    Given I am on the login page
    And I fill in "username" with "Tiancheng"
    And I fill in "password" with "123456"
    When I click "submit"
    Then I should see "Welcome"



