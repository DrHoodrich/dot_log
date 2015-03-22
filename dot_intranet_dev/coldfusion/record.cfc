<cfscript>
component Record {
//        variables.full_name = "";
        //variables.hubAirportID = [];
        
        variables.result = [];
        variables.records = [];
        variables.recordNumber = 0;

        public Record function init(required numeric airportID)
        {
                queryService = new query();

                queryService.setName("getAirportRecords");
                queryService.setDataSource("DOTlogDB");
                queryService.addParam(name = "hub_airport_ID", value = airportID, cfsqltype = "cf_sql_number");

                queryResult = queryService.execute(sql = "SELECT * FROM DAL_LOG_ENTRIES WHERE AIRPORT_ID = :hub_airport_ID");


                variables.result = queryResult.getResult();
                
                return this;
        }

        public array function getAirport() 
        {
                /*TODO - format to the database result*/
                for (ii = 1; ii <= variables.result.recordcount; ++ii) {
                        variables.records[ii] = variables.result["airport_id"][ii];
                }
                return variables.records;
        }

        public array function getReporter() 
        {
                /*TODO - format to the database result*/
                for (ii = 1; ii <= variables.result.recordcount; ++ii) {
                        variables.records[ii] = variables.result["user_id"][ii];
                }
                return variables.records;
        }

        public array function getCategory() 
        {
                /*TODO - format to the database result*/
                for (ii = 1; ii <= variables.result.recordcount; ++ii) {
                        variables.records[ii] = variables.result["category_id"][ii];
                }
                return variables.records;
        }

        public array function getDate() 
        {
                /*TODO - format to the database result*/
                for (ii = 1; ii <= variables.result.recordcount; ++ii) {
                        variables.records[ii] = variables.result["time_of_event"][ii];
                }
                return variables.records;
        }

        public array function getDescriptions()
        {
                for (ii = 1; ii <= variables.result.recordcount; ++ii) {
                        variables.records[ii] = variables.result["description"][ii];
                }
                return variables.records;
        }

        public iterator function getRecord()
        {
                recordArray = ArrayNew(2);

                iter = recordArray.iterator();
                return iter;
        }
}
</cfscript>