<cfscript>
/**
* @author Spring 2015 CS 471 Group 1
* A sample of documenting a component.
*/
component User displayname = "User Class" hint = "Used to get user data" {
        
        userName = "";
        full_name = "";
        initials = "";
        userID = -1;
        arrayAirportNames = [];
        arrayAirportIDs = [];
        
        public User function init(required string userName)
        {
                userName = arguments.userName;
                var result = Session.databaseConnector.getUser(arguments.userName);
                full_name = result["Name"][1];
                userID = result["User_ID"][1];


                result = Session.databaseConnector.getAirports();
                for (var ii = 1; ii <= result.recordcount; ++ii) {
                        arrayAirportNames[ii] = result["Name"][ii];
                        arrayAirportIDs[ii] = result["Airport_ID"][ii];
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

        public array function getAirportIDs()
        {
                return arrayAirportIDs;
        }

        public numeric function getID()
        {
                return userID;
        }
}
</cfscript>