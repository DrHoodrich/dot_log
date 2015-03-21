<cfscript>
component Record {
//        variables.full_name = "";
        //variables.hubAirportID = [];
        variables.recordStub = queryNew("record_id, airport_id, category_id, user_id, description, time_of_entry, time_of_event, priority");
        variables.records = [];

        public Record function init()
        {
                /*TODO - pull from the database: make sure enabled */
                queryAddRow(variables.recordStub);
                querySetCell(variables.recordStub, 'record_id', '1');
                querySetCell(variables.recordStub, 'airport_id', '21');
                querySetCell(variables.recordStub, 'category_id', '1');
                querySetCell(variables.recordStub, 'user_id', '1');
                querySetCell(variables.recordStub, 'description', 'The Airport was destroyed by aliens');
                querySetCell(variables.recordStub, 'time_of_entry', '2pm');
                querySetCell(variables.recordStub, 'time_of_event', '1pm');
                querySetCell(variables.recordStub, 'priority', '1');

                queryAddRow(variables.recordStub);
                querySetCell(variables.recordStub, 'record_id', '1');
                querySetCell(variables.recordStub, 'airport_id', '21');
                querySetCell(variables.recordStub, 'category_id', '1');
                querySetCell(variables.recordStub, 'user_id', '1');
                querySetCell(variables.recordStub, 'description', 'The Airport was destroyed by aliens again');
                querySetCell(variables.recordStub, 'time_of_entry', '2pm');
                querySetCell(variables.recordStub, 'time_of_event', '3pm');
                querySetCell(variables.recordStub, 'priority', '1');
                
                queryAddRow(variables.recordStub);
                querySetCell(variables.recordStub, 'record_id', '1');
                querySetCell(variables.recordStub, 'airport_id', '21');
                querySetCell(variables.recordStub, 'category_id', '1');
                querySetCell(variables.recordStub, 'user_id', '1');
                querySetCell(variables.recordStub, 'description', 'The Airport was destroyed by aliens one last time');
                querySetCell(variables.recordStub, 'time_of_entry', '2pm');
                querySetCell(variables.recordStub, 'time_of_event', '4pm');
                querySetCell(variables.recordStub, 'priority', '1');
                return this;
        }

        public array function getAirport() 
        {
                /*TODO - format to the database result*/
                for (ii = 1; ii <= variables.recordStub.recordcount; ++ii) {
                        variables.records[ii] = variables.recordStub["airport_id"][ii];
                }
                return variables.records;
        }

        public array function getReporter() 
        {
                /*TODO - format to the database result*/
                for (ii = 1; ii <= variables.recordStub.recordcount; ++ii) {
                        variables.records[ii] = variables.recordStub["user_id"][ii];
                }
                return variables.records;
        }

        public array function getCategory() 
        {
                /*TODO - format to the database result*/
                for (ii = 1; ii <= variables.recordStub.recordcount; ++ii) {
                        variables.records[ii] = variables.recordStub["category_id"][ii];
                }
                return variables.records;
        }

        public array function getDate() 
        {
                /*TODO - format to the database result*/
                for (ii = 1; ii <= variables.recordStub.recordcount; ++ii) {
                        variables.records[ii] = variables.recordStub["time_of_event"][ii];
                }
                return variables.records;
        }

        public array function getDescriptions() 
        {
                /*TODO - format to the database result*/
                for (ii = 1; ii <= variables.recordStub.recordcount; ++ii) {
                        variables.records[ii] = variables.recordStub["description"][ii];
                }
                return variables.records;
        }
}
</cfscript>