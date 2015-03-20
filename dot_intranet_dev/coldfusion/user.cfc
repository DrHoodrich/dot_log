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
                variables.hubAirportID[1] = "Clear";
                variables.hubAirportID[2] = "Fairbanks";
                return variables.hubAirportID;
        }
}
</cfscript>