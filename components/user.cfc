<cfscript>
/**
* @author Spring 2015 CS 471 Group 1
* A sample of documenting a component.
*/
component User displayname = "User Class" hint = "Used to get user data" {
        full_name = "";
        hubAirportID = [];
        userID = -1;

        /**
        * Constructor 
        * @description None
        * @Postconditions.hint None
        * @ThrowSafety.hint: Non Throw
        * @name.hint is the name of the DOTLog user
        */
        public User function init(required string name)
        {
                full_name = arguments.name;
                userID = 1;
                return this;
        }

        /**
        * Get the full name of the user
        * @
        */
        public string function getName() 
        {
                return full_name;
        }

        public array function getAirportName()
        {
                hubAirportID[1] = "Clear";
                hubAirportID[2] = "Fairbanks";
                return hubAirportID;
        }

        public array function getAirportID()
        {
                hubAirportID[1] = "25";
                hubAirportID[2] = "1";
                return hubAirportID;
        }

        public numeric function getID()
        {
                return userID;
        }
}
</cfscript>