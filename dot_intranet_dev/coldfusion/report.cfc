<cfscript>
component User {
        variables.full_name = "";
        variables.hubAirportID = [];

        public User function init(required string name)
        {
                full_name = arguments.name;
                return this;
        }

        public string function getName() 
        {
                return variables.full_name;
        }

        public array function getAirportID()
        {
                variables.hubAirportID[1] = 25;
                variables.hubAirportID[2] = 26;
                return variables.hubAirportID;
        }
}
</cfscript>