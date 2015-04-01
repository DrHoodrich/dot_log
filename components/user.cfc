<cfscript>
/**
* @author Spring 2015 CS 471 Group 1
* A sample of documenting a component.
*/
component User displayname = "User Class" hint = "Used to get user data" {
        databaseConnector = new database();
        full_name = "";
        userID = -1;
        AirportNames = [];
        AirportFAACodes = [];
        
        public User function init(required string dot_username)
        {
                full_name = arguments.dot_username;
                userID = 1;

                result = databaseConnector.getAirports();

                for (var ii = 1; ii <= result.recordcount; ++ii) {
                        arrayAirportNames[ii] = result["airport_name"][ii];
                        arrayAirportFAACodes[ii] = result["faa_code"][ii];
                }                              
                return this;
        }

        public string function getName() 
        {
                return full_name;
        }

        public array function getAirportNames()
        {
                return arrayAirportNames;
        }

        public array function getAirportFAACodes()
        {
                return arrayAirportFAACodes;
        }

        public numeric function getID()
        {
                return userID;
        }
}
</cfscript>