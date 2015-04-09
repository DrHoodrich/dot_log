component RecordDAO extends="CoreUtils"
{
	variables.instance = {
		datasource = ''
	};

	public RecordDAO function init(required datasource datasource)
	{
		variables.instance.datasource = arguments.datasource;
		return this;
	} 

	public boolean function saveRecord(required record record)
	{
		if ( record.getRecordID() ) {
			if (recordExists(record)) {
				return updateRecord(record);	
			}
			return createRecord(arguments.Record);
		} else { 
			return false;	
		} 
	}

	public numeric function getRecordID(record record)
	{
		var queryHandler = getQueryHandler("updateRecord", arguments.record);

		// Need to make sure that this is uniquely IDing
		queryResult = queryHandler.execute(sql = "SELECT record_id FROM DL_RECORDS 
			WHERE username = :username AND record_text = :record_text AND record_time = :record_time ");
		
		result = queryResult.getResult();


		if (result.recordCount) {
			return result["record_id"][1];
		} else {
			return -1;
		}
	}

	private boolean function createRecord(required record record)
	{
		var queryHandler = getQueryHandler("createRecord", arguments.record);
		
 		transaction action="begin" {
			try {
				queryResult = queryHandler.execute(sql = "INSERT INTO DL_RECORDS 
					(record_text, username, faa_code, event_time, record_time, in_weekly_report, category_title) 
					VALUES (:record_text, :username, :faa_code, :event_time, :record_time, :in_weekly_report, :category_title)");
			} catch (database excpt) {
				transactionRollback();
				return false;
			}
		}
		return true;
	}

	private boolean function updateRecord(required record record)
	{
		var queryHandler = getQueryHandler("updateRecord", arguments.record);

		transaction action="begin" {
			try {
				queryResult = queryHandler.execute(sql = "UPDATE DL_RECORDS SET 
					record_text = :record_text, faa_code = :faa_code, event_time = :event_time, in_weekly_report = :in_weekly_report, category_title = :category_title 
					WHERE record_id = :record_id");
			} catch (database excpt) {
				transactionRollback();
				return false;
			}
		}
		return true;
	}	

	private boolean function recordExists(required record record)
	{
		
		var queryHandler = getQueryHandler("doesRecordExist", arguments.record);
		queryResult = queryHandler.execute(sql = "SELECT record_id FROM DL_RECORDS WHERE record_id = :record_id");
		
		return queryResult.getResult().recordCount;
	}

	private base function getQueryHandler(required string queryName, required record record)
	{
		var queryService = new query();

		queryService.setName(arguments.queryName);
		queryService.setDataSource(variables.instance.datasource.getDSName());
		queryService.setUsername(variables.instance.datasource.getUsername());
		queryService.setPassword(variables.instance.datasource.getPassword());

		if (record.getRecordID()) {
			queryService.addParam(name = "record_id", value = arguments.record.getRecordID(), cfsqltype = "cf_sql_number");
		}
		queryService.addParam(name = "record_text", value = arguments.record.getRecordText(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "username", value = arguments.record.getUsername(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "faa_code", value = arguments.record.getAirportFAACode(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "event_time", value = arguments.record.getEventTime(), cfsqltype = "cf_sql_timestamp");
		queryService.addParam(name = "record_time", value = arguments.record.getRecordTime(), cfsqltype = "cf_sql_timestamp");
		queryService.addParam(name = "in_weekly_report", value = arguments.record.isInWeeklyReport(), cfsqltype = "cf_sql_number");
		queryService.addParam(name = "category_title", value = arguments.record.getCategory(), cfsqltype = "cf_sql_varchar");

		return queryService;
	}
}