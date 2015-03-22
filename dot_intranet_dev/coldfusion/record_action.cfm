<cfscript>
	writeDump(Form);
	writeOutput(Form.log_report);

	queryService = new query();

	datetime = CREATEODBCDATETIME( now() );

	writeDump(datetime);

		queryService.setName("insertRecord");
		queryService.setDataSource("DOTlogDB");
		//queryService.addParam(name = "hub_airport_ID", value = "21", cfsqltype = "cf_sql_number");
		queryService.addParam(name = "current_time", value = datetime, cfsqltype = "cf_sql_timestamp");
		queryService.addParam(name = "current_time1", value = datetime, cfsqltype = "cf_sql_timestamp");
writeDump(queryService);
		queryResult = queryService.execute(sql = "INSERT INTO DAL_LOG_ENTRIES (AIRPORT_ID, CATEGORY_ID, USER_ID, DESCRIPTION, TIME_OF_ENTRY, TIME_OF_EVENT) VALUES ('25', '2', '#Form.USER_ID#', '#Form.LOG_REPORT#', :current_time, :current_time)");
</cfscript>