<cfscript>
component Database {
	DBqueryHandler = new query();

	recordTableName = "DL_RECORDS";
	userTableName = "DL_USERS";
	categoryTableName = "DL_CATEGORIES";
	airportTableName = "DL_AIRPORTS";

	public Database function init()
	{
		DBqueryHandler.setDataSource("DOTlogDB");
		return this;
	}

	public query function getRecentHubRecords(required string airportCode)
	{
		DBqueryHandler.setName("getAirportRecords");
		DBqueryHandler.addParam(name = "faa_code", value = arguments.airportCode, cfsqltype = "cf_sql_varchar");

		queryResult = DBqueryHandler.execute(sql = "SELECT * FROM #recordTableName# 
			WHERE faa_code = :faa_code 
			ORDER BY record_time DESC");
		return queryResult.getResult();
	}

	public void function addCategory(required string categoryTitle)
	{
		DBqueryHandler.setName("newCategory");
		DBqueryHandler.addParam(name = "category_title", value = arguments.categoryTitle, cfsqltype = "cf_sql_varchar");
		DBqueryHandler.addParam(name = "description", value = "another fire", cfsqltype = "cf_sql_varchar");
		DBqueryHandler.addParam(name = "enabled", value = "1", cfsqltype = "cf_sql_number");
		DBqueryHandler.addParam(name = "in_weekly_report", value = "0", cfsqltype = "cf_sql_number");
		queryResult = DBqueryHandler.execute(sql = "INSERT INTO #categoryTableName# 
			(category_title, description, enabled, in_weekly_report) 
			VALUES (:category_title, :description, :enabled, :in_weekly_report)");
	}

	public query function getCategories()
	{
		DBqueryHandler.setName("getCategories");
		queryResult = DBqueryHandler.execute(sql = "SELECT category_title, description FROM #categoryTableName#");
		return queryResult.getResult();
	}

	public query function getAirports()
	{
		DBqueryHandler.setName("getAirports");
		queryResult = DBqueryHandler.execute(sql = "SELECT faa_code, airport_name FROM #airportTableName#");
		return queryResult.getResult();
	}

	public void function saveRecord(required string eventDescription, 
									required string userName, 
									required string faaCode, 
									required string categoryTitle) 
	{
		var recordSubmissionTime = CREATEODBCDATETIME( now() );

		DBqueryHandler.setName("insertRecord");
		
		DBqueryHandler.addParam(name = "record_text", value = arguments.eventDescription, cfsqltype = "cf_sql_varchar");
		DBqueryHandler.addParam(name = "username", value = "us" , cfsqltype = "cf_sql_varchar");
		DBqueryHandler.addParam(name = "faa_code", value = arguments.faaCode, cfsqltype = "cf_sql_varchar");
		DBqueryHandler.addParam(name = "event_time", value = recordSubmissionTime, cfsqltype = "cf_sql_timestamp");
		DBqueryHandler.addParam(name = "record_time", value = recordSubmissionTime, cfsqltype = "cf_sql_timestamp");
		DBqueryHandler.addParam(name = "in_weekly_report", value = 0, cfsqltype = "cf_sql_number");
		DBqueryHandler.addParam(name = "category_title", value = arguments.categoryTitle, cfsqltype = "cf_sql_varchar");

		queryResult = DBqueryHandler.execute(sql = "INSERT INTO #recordTableName# 
			(record_text, username, faa_code, event_time, record_time, in_weekly_report, category_title)
			VALUES (:record_text, :username, :faa_code, :event_time, :record_time, :in_weekly_report, :category_title)");


	}
}
</cfscript>