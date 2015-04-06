component RecordGateway
{
	public RecordGateway function init(required dotlog.components.datasource datasource)
	{
		variables.instance.datasource = arguments.datasource;
		return this;
	}

	public array function getRecordsByUsername(required string username)
	{
		var recordObjects = [];

		DSname = variables.instance.datasource.getDSName();
		DSusername = variables.instance.datasource.getUsername();
		DSpassword = variables.instance.datasource.getPassword();

		var queryService = new query();

		queryService.setName("fetchRecordByUsername");
		queryService.setDataSource(variables.instance.datasource.getDSName());
		queryService.setUsername(DSusername);
		queryService.setPassword(DSpassword);

		queryService.addParam(name = "username", value = arguments.username, cfsqltype = "cf_sql_varchar");
		queryResult = queryService.execute(sql = "SELECT record_id, record_text, username, faa_code, event_time, record_time, in_weekly_report, category_title 
			FROM DL_RECORDS WHERE username = :username");
		result = queryResult.getResult();

		if (result.RecordCount) {
			for (var ii = 1; ii <= result.RecordCount; ++ii) {
			 recordObject = new Record(recordID = result["record_id"],
			 				recordText = result["record_text"][ii],
							username = result["username"][ii],
							faaCode = result["faa_code"][ii],
							eventTime = result["event_time"][ii],
							recordTime = result["record_time"][ii],
							inWeeklyReport = result["in_weekly_report"][ii],
							categoryTitle = result["category_title"][ii]);
			 arrayAppend(recordObjects, recordObject);
			}
		}
		return recordObjects;
	}

	public array function getRecordsByAirportFAACode(required string faaCode)
	{
		var recordObjects = [];

		DSname = variables.instance.datasource.getDSName();
		DSusername = variables.instance.datasource.getUsername();
		DSpassword = variables.instance.datasource.getPassword();

		var queryService = new query();

		queryService.setName("fetchRecordsByFAACode");
		queryService.setDataSource(variables.instance.datasource.getDSName());
		queryService.setUsername(DSusername);
		queryService.setPassword(DSpassword);

		queryService.addParam(name = "faa_code", value = arguments.faaCode, cfsqltype = "cf_sql_varchar");
		queryResult = queryService.execute(sql = "SELECT record_text, username, faa_code, event_time, record_time, in_weekly_report, category_title 
			FROM DL_RECORDS WHERE faa_code = :faa_code 
			ORDER BY event_time DESC");
		result = queryResult.getResult();

		for (var ii = 1; ii <= result.RecordCount; ++ii) {
			 recordObject = new Record(recordText = result["record_text"][ii],
							username = result["username"][ii],
							faaCode = result["faa_code"][ii],
							eventTime = result["event_time"][ii],
							recordTime = result["record_time"][ii],
							inWeeklyReport = result["in_weekly_report"][ii],
							categoryTitle = result["category_title"][ii]);
			 arrayAppend(recordObjects, recordObject);
		}
		return recordObjects;
	}
}