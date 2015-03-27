<cfscript>
component Record {
        result = new query();

        arrayAirportCodes = [];
        arrayReporters = [];
        arrayCategories = [];
        arrayRecordTimes = [];
        arrayDescriptions = [];

        //databaseConnector = new database();

        public Record function init(required numeric airportID)
        {                  
                result = Session.databaseConnector.getRecentHubRecords(arguments.airportID);

                for (var ii = 1; ii <= result.recordcount; ++ii) {
                        arrayAirportCodes[ii] = result["airport_id"][ii];
                        arrayReporters[ii] = result["user_id"][ii];
                        arrayCategories[ii] = result["category_id"][ii];
                        arrayRecordTimes[ii] = result["time_of_event"][ii];
                        arrayDescriptions[ii] = result["description"][ii];
                }                              
                return this;
        }

        public array function getAirport() 
        {
                return arrayAirportCodes;
        }

        public array function getReporter() 
        {
                return arrayReporters;
        }

        public array function getCategory() 
        {
                return arrayCategories;
        }

        public array function getDate() 
        {
                return arrayRecordTimes;
        }

        public array function getDescriptions()
        {
                return arrayDescriptions;
        }
}
</cfscript>