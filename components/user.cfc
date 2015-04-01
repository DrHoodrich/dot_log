
/**
* @author Spring 2015 CS 471 Group 1
* A sample of documenting a component.
*/

/**
* @hint a user class bean
* Simple class for representing users of DOTLog
*/

component User 
{
     property name="username" type="string" default="" hint="The DOT based username."; 
     property name="firstName" type="string" default="" hint="The DOT based username.";
     property name="lastName" type="string" default="" hint="The DOT based username.";
     property name="permissions" type="numeric" default="" hint="The DOT based username.";
     property name="airportFAACode" type="string" default="" hint="DOT employee hub airport.";
     property name="enabled" type="numeric" default="" hint="If the employee is enabled to use DOTLog.";
        
        public User function init(required string username,
                                  required string firstName,
                                  required string lastName,
                                  required string faaCode,
                                  required numeric permissions,
                                  required numeric enabled)
        {
                variables.username = arguments.username;
                variables.firstName = arguments.firstName;
                variables.lastName = arguments.lastName;
                variables.permissions = arguments.permissions;
                variables.airportFAACode = arguments.faaCode;
                variables.enabled = arguments.enabled;

                return this;
        }

        public string function getFirstName()
        {
            return firstName;
        }

        public string function getLastName()
        {
            return lastName;
        }

        public string function getFullName() 
        {
                return firstName & " " & lastName;
        }

        public string function getAirportFAACode()
        {
                return airportFAACode;
        }

        public string function getUsername()
        {
                return username;
        }

        public string function getInitials()
        {
                return Left(firstName, 1)&"."&Left(lastName, 1)&".";
        }

        public boolean function isEnabled()
        {
            if (enabled >= 1) {
                return true;
            } else {
                return false;
            }
        }

}