/**
* @author Spring 2015 CS 471 Group 1
* A sample of documenting a component.
*/

/**
* @hint a user class bean
* Simple class for representing users of DOTLog
*/

component User extends="coreUtils"
{
    variables.instance = {
        username = '', 
        firstName = '',
        lastName = '',
        permissions = '',
        airportFAACode = '',
        enabled = '',
        emailAddr = '' 
    };

        
        public User function init(required string username,
                                  required string firstName,
                                  required string lastName,
                                  required string faaCode,
                                  required numeric permissions,
                                  required numeric enabled,
                                  required string emailAddr)
        {
                variables.instance.username = arguments.username;
                variables.instance.firstName = arguments.firstName;
                variables.instance.lastName = arguments.lastName;
                variables.instance.permissions = arguments.permissions;
                variables.instance.airportFAACode = arguments.faaCode;
                variables.instance.enabled = arguments.enabled;
                variables.instance.emailAddr = arguments.emailAddr;

                return this;
        }

        public string function getFirstName()
        {
            return variables.instance.firstName;
        }

        public string function getLastName()
        {
            return variables.instance.lastName;
        }

        public string function getFullName() 
        {
                return variables.instance.firstName & " " & variables.instance.lastName;
        }

        public string function getAirportFAACode()
        {
                return variables.instance.airportFAACode;
        }

        public string function getUsername()
        {
                return variables.instance.username;
        }

        public string function getInitials()
        {
                return Left(variables.instance.firstName, 1)&"."&Left(variables.instance.lastName, 1)&".";
        }

        public numeric function getPermissions()
        {
                return variables.instance.permissions;
        }
        
        public boolean function isEnabled()
        {
            return (variables.instance.enabled);
        }

        public string function getEmailAddr()
        {
                return variables.instance.emailAddr;
        }
}
