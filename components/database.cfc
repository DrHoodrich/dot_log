<cfscript>
component Database {
	DBqueryHandler = new query();

	recordTableName = "DAL_LOG_ENTRIES";
	userTableName = "DAL_USERS";
	categoryTableName = "DAL_CATEGORIES";
	airportTableName = "DAL_AIRPORTS";

	public Database function init()
	{
		DBqueryHandler.setDataSource("DOTlogDB");
		return this;
	}

	public query function getRecentHubRecords(required numeric airportID)
	{
		DBqueryHandler.setName("getAirportRecords");
		DBqueryHandler.addParam(name = "hub_airport_ID", value = arguments.airportID, cfsqltype = "cf_sql_number");

		queryResult = DBqueryHandler.execute(sql = "SELECT * FROM #recordTableName# 
			WHERE AIRPORT_ID = :hub_airport_ID 
			ORDER BY TIME_OF_ENTRY DESC");
		return queryResult.getResult();
	}

	public void function addCategory(required string categoryName)
	{
		DBqueryHandler.setName("newCategory");
		DBqueryHandler.addParam(name = "categoryName", value = arguments.categoryName, cfsqltype = "cf_sql_varchar");
		DBqueryHandler.addParam(name = "airportID", value = 666, cfsqltype = "cf_sql_number");
		queryResult = DBqueryHandler.execute(sql = "INSERT INTO #categoryTableName# 
			(Name, Airport_ID) 
			VALUES (:categoryName, :airportID)");
	}

	public query function getCategories()
	{
		DBqueryHandler.setName("getCategories");
		queryResult = DBqueryHandler.execute(sql = "SELECT Category_ID, Name FROM #categoryTableName#");
		return queryResult.getResult();
	}

	public query function getAirports()
	{
		DBqueryHandler.setName("getAirports");
		queryResult = DBqueryHandler.execute(sql = "SELECT Airport_ID, Name FROM #airportTableName#");
		return queryResult.getResult();
	}

	public void function saveRecord(required string userID, required eventDescription) 
	{
		var recordSubmittionTime = CREATEODBCDATETIME( now() );

		DBqueryHandler.setName("insertRecord");
		
		DBqueryHandler.addParam(name = "current_time", value = recordSubmittionTime, cfsqltype = "cf_sql_timestamp");
		DBqueryHandler.addParam(name = "user_ID", value = arguments.userID, cfsqltype = "cf_sql_number");
		DBqueryHandler.addParam(name = "event_description", value = arguments.eventDescription, cfsqltype = "cf_sql_varchar");

		queryResult = DBqueryHandler.execute(sql = "INSERT INTO #recordTableName# 
			(AIRPORT_ID, CATEGORY_ID, USER_ID, DESCRIPTION, TIME_OF_ENTRY, TIME_OF_EVENT)
			VALUES ('25', '2', :user_ID, :event_description, :current_time, :current_time)");
	}
}
</cfscript>