<cfscript>
component Category {
//        variables.full_name = "";
        //variables.hubAirportID = [];
        variables.categoryStub = queryNew("category_id, name");
        variables.possibleCategoryNames = [];
        

        public Category function init()
        {
                /*TODO - pull from the database: make sure enabled */
                queryAddRow(variables.categoryStub);
                querySetCell(variables.categoryStub, 'category_id', '1');
                querySetCell(variables.categoryStub, 'name', 'Lighting');


                queryAddRow(variables.categoryStub);
                querySetCell(variables.categoryStub, 'category_id', '2');
                querySetCell(variables.categoryStub, 'name', 'Fuel');

                return this;
        }

        public Record function getSerchForm(required numeric airport_id) 
        {
                record = new Record();

                queryService = new query();

                /* TODO Write query */
                queryService.setName("seachAirportRecords");
                queryService.setDataSource("DOTlogDB");
                queryService.addParam(name = "hub_airport_ID", value = "21", cfsqltype = "cf_sql_number");

                queryResult = queryService.execute(sql = "SELECT * FROM DAL_AIRPORTS WHERE AIRPORT_ID = :hub_airport_ID OR PID = :hub_airport_ID");
        }
}
</cfscript>