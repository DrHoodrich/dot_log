<cfscript>
component Record {
        result = new query();

        RecordAirportFAACodes = [];
        RecordUsers = [];
        RecordCategories = [];
        RecordTimes = [];
        RecordText = [];
        RecordInWeeklyReport = [];
        RecordEventTimes = [];

        databaseConnector = new database();

        public Record function init(required string airportCode)
        {                  
                result = databaseConnector.getRecentHubRecords(arguments.airportCode);

                for (var ii = 1; ii <= result.recordcount; ++ii) {
                        RecordAirportFAACodes[ii] = result["faa_code"][ii];
                        RecordUsers[ii] = result["username"][ii];
                        RecordCategories[ii] = result["category_title"][ii];
                        RecordTimes[ii] = result["event_time"][ii];
                        RecordText[ii] = result["record_text"][ii];
                        RecordInWeeklyReport[ii] = result["in_weekly_report"][ii];
                }                              
                return this;
        }

        public array function getRecordAirportFAACodes() 
        {
                return RecordAirportFAACodes;
        }

        public array function getRecordUsers() 
        {
                return RecordUsers;
        }

        public array function getRecordCategories() 
        {
                return RecordCategories;
        }

        public array function getRecordTimes() 
        {
                return RecordTimes;
        }

        public array function getRecordText()
        {
                return RecordText;
        }
}
</cfscript>