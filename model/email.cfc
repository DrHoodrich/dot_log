component Email extends = "dotlog.model.dataAccess.DAO"
{
	variables.queryHandler = '';

	public Email function init(required dotlog.model.beans.datasource datasource)
	{
		variables.queryHandler = new dotlog.model.queryHandler(arguments.datasource);
		return this;
	}

	public any function getRegionAdminEmails(required numeric regionID)
	{
		var datasource = new dotlog.model.beans.datasource(DSName = "DOTlogDB", username = "", password = "");
		variables.queryHandler = new dotlog.model.queryHandler(datasource);
		var queryHandler = getQueryHandler("updateReport", arguments.regionID);
		sqlString = "SELECT first_name, last_name, email_addr " &
					"FROM (((DL_REGIONS NATUAL JOIN DL_DISTRICTS USING (region_id)) " &
         				"JOIN DL_AIRPORTS USING (district_id)) " &
              			"JOIN DL_USERS USING (faa_code)) " &
					"WHERE 1 = 1 " &
						"AND REGION_ID = :regionID " &
						"AND DL_USERS.enabled = 1 " &
						"AND DL_USERS.user_permissions = 1" ;
		
		queryResult = variables.queryHandler.executeQuery(queryHandler, sqlString);
		result = queryResult.getResult();
//		writeDump(queryResult.getResult());
//writeDump(result);
//		var emails = [];
//		for (var ii = 1; ii <= result.RecordCount; ++ii) {		
//			 arrayAppend(emails, result["email_addr"][ii]);
//		}
//		return emails;
		return result;
	}

	private base function getQueryHandler(required string queryName, required numeric regionID)
	{
		var queryHandler = new query();

		queryHandler.setName(arguments.queryName);
		queryHandler.addParam(name = "regionID", value = arguments.regionID, cfsqltype = "cf_sql_number");

		return queryHandler;
	}
}