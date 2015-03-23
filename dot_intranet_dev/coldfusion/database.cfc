<cfscript>
component Database {
	variables.DBqueryHandler = new query();

	variables.recordTableName = "DAL_LOG_ENTRIES";
	variables.userTableName = "DAL_USERS";
	variables.categoryTableName = "DAL_CATEGORIES";
	variables.airportTableName = "DAL_AIRPORTS";

	public Database function init()
	{
		DBqueryHandler.setDataSource("DOTlogDB");
		return this;
	}

	public query function getRecentHubRecords(required numeric airportID)
	{
		DBqueryHandler.setName("getAirportRecords");
		DBqueryHandler.addParam(name = "hub_airport_ID", value = airportID, cfsqltype = "cf_sql_number");

		queryResult = DBqueryHandler.execute(sql = "SELECT * FROM #variables.recordTableName# 
			WHERE AIRPORT_ID = :hub_airport_ID 
			ORDER BY TIME_OF_ENTRY DESC");
		return queryResult.getResult();
	}

	public void function saveRecord(required string userID, required eventDescription) {
		recordSubmittionTime = CREATEODBCDATETIME( now() );

		DBqueryHandler.setName("insertRecord");
		
		DBqueryHandler.addParam(name = "current_time", value = recordSubmittionTime, cfsqltype = "cf_sql_timestamp");
		DBqueryHandler.addParam(name = "user_ID", value = userID, cfsqltype = "cf_sql_number");
		DBqueryHandler.addParam(name = "event_description", value = eventDescription, cfsqltype = "cf_sql_varchar");

		queryResult = DBqueryHandler.execute(sql = "INSERT INTO #variables.recordTableName# 
			(AIRPORT_ID, CATEGORY_ID, USER_ID, DESCRIPTION, TIME_OF_ENTRY, TIME_OF_EVENT)
			VALUES ('25', '2', :user_ID, :event_description, :current_time, :current_time)");
	}
}
</cfscript>