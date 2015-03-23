<cfscript>
component Record {
        variables.result = new query();

        variables.arrayAirportCodes = [];
        variables.arrayReporters = [];
        variables.arrayCategories = [];
        variables.arrayRecordTimes = [];
        variables.arrayDescriptions = [];

        variables.databaseConnector = new database();

        public Record function init(required numeric airportID)
        {                  
                variables.result = variables.databaseConnector.getRecentHubRecords(airportID);

                for (ii = 1; ii <= variables.result.recordcount; ++ii) {
                        variables.arrayAirportCodes[ii] = variables.result["airport_id"][ii];
                        variables.arrayReporters[ii] = variables.result["user_id"][ii];
                        variables.arrayCategories[ii] = variables.result["category_id"][ii];
                        variables.arrayRecordTimes[ii] = variables.result["time_of_event"][ii];
                        variables.arrayDescriptions[ii] = variables.result["description"][ii];
                }                              
                return this;
        }

        public array function getAirport() 
        {
                return variables.arrayAirportCodes;
        }

        public array function getReporter() 
        {
                return variables.arrayReporters;
        }

        public array function getCategory() 
        {
                return variables.arrayCategories;
        }

        public array function getDate() 
        {
                return variables.arrayRecordTimes;
        }

        public array function getDescriptions()
        {
                return variables.arrayDescriptions;
        }
}
</cfscript>