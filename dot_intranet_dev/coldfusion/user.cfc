<cfscript>
component User {
        variables.full_name = "";
        variables.hubAirportID = [];
        variables.userID = -1;

        public User function init(required string name)
        {
                full_name = arguments.name;
                variables.userID = 1;
                return this;
        }

        public string function getName() 
        {
                return variables.full_name;
        }

        public array function getAirportName()
        {
                variables.hubAirportID[1] = "Clear";
                variables.hubAirportID[2] = "Fairbanks";
                return variables.hubAirportID;
        }

        public array function getAirportID()
        {
                variables.hubAirportID[1] = "25";
                variables.hubAirportID[2] = "1";
                return variables.hubAirportID;
        }

        public numeric function getID()
        {
                return variables.userID;
        }
}
</cfscript>