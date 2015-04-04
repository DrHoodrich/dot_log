component RecordDAO
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
		if ( recordExists(record) ) {
			return updateRecord(arguments.Record);
		} else {
			return createRecord(arguments.Record);
		}
	}

	public boolean function updateRecord(required record record)
	{
		var report = '';
		if (record.isInWeeklyReport()) {
			report = 1;
		} else {
			report = 0;
		}

		var queryService = new query();

		queryService.setName("updateRecord");
		queryService.setDataSource(variables.instance.datasource.getDSName());

		queryService.addParam(name = "record_text", value = arguments.record.getRecordText(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "username", value = arguments.record.getUsername(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "faa_code", value = arguments.record.getAirportFAACode(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "event_time", value = arguments.record.getEventTime(), cfsqltype = "cf_sql_timestamp");
		queryService.addParam(name = "record_time", value = arguments.record.getRecordTime(), cfsqltype = "cf_sql_timestamp");
		queryService.addParam(name = "category_title", value = arguments.record.getCategory(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "in_weekly_report", value = report, cfsqltype = "cf_sql_number");

		recordID = '';
		if (recordExists(arguments.record)) {
			recordID = getRecordID(arguments.record);
		} else {
			return false;
		}

		queryService.addParam(name = "record_id", value = recordID, cfsqltype = "cf_sql_number");

		transaction action="begin"
		{
			try {

				queryResult = queryService.execute(sql = "UPDATE DL_RECORDS SET 
					record_text = :record_text, faa_code = :faa_code, event_time = :event_time, in_weekly_report = :in_weekly_report, category_title = :category_title 
					WHERE record_id = :record_id");
				return true;
			} catch (database excpt) {
				transactionRollback();
				return false;
			}
		}
	}	

	public boolean function createRecord(required record record)
	{
		var queryService = new query();

		queryService.setName("createRecord");
		queryService.setDataSource(variables.instance.datasource.getDSName());

		queryService.addParam(name = "record_text", value = arguments.record.getRecordText(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "username", value = arguments.record.getUsername(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "faa_code", value = arguments.record.getAirportFAACode(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "event_time", value = arguments.record.getEventTime(), cfsqltype = "cf_sql_timestamp");
		queryService.addParam(name = "record_time", value = arguments.record.getRecordTime(), cfsqltype = "cf_sql_timestamp");
		if (record.isInWeeklyReport()) {
			report = 1;
		} else {
			report = 0;
		}
		queryService.addParam(name = "in_weekly_report", value = report, cfsqltype = "cf_sql_number");
		queryService.addParam(name = "category_title", value = arguments.record.getCategory(), cfsqltype = "cf_sql_varchar");
		
		queryResult = queryService.execute(sql = "INSERT INTO DL_RECORDS 
			(record_text, username, faa_code, event_time, record_time, in_weekly_report, category_title) 
			VALUES (:record_text, :username, :faa_code, :event_time, :record_time, :in_weekly_report, :category_title)");

		return 0;
	}

	private numeric function getRecordID(record record)
	{
		var queryService = new query();

		queryService.setName("GetRecordID");
		queryService.setDataSource(variables.instance.datasource.getDSName());

		queryService.addParam(name = "record_text", value = arguments.record.getRecordText(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "username", value = arguments.record.getUsername(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "faa_code", value = arguments.record.getAirportFAACode(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "event_time", value = arguments.record.getEventTime(), cfsqltype = "cf_sql_timestamp");
		queryService.addParam(name = "record_time", value = arguments.record.getRecordTime(), cfsqltype = "cf_sql_timestamp");
		queryService.addParam(name = "category_title", value = arguments.record.getCategory(), cfsqltype = "cf_sql_varchar");



		queryResult = queryService.execute(sql = "SELECT record_id FROM DL_RECORDS WHERE record_text = :record_text"); 
		
		result = queryResult.getResult();
		writeDump(result);
		if (!arrayIsEmpty(result["record_id"])) {
			return result["record_id"][1];
		} else {
			return -1;
		}
	}

	private boolean function recordExists(record record)
	{
		var queryService = new query();
		queryService.setDataSource(variables.instance.datasource.getDSName());
		queryService.setUsername(variables.instance.datasource.getUsername());
		queryService.setPassword(variables.instance.datasource.getPassword());

		recordID = getRecordID(record);

		queryService.addParam(name = "record_id", value = recordID, cfsqltype = "cf_sql_number");
		queryResult = queryService.execute(sql = "SELECT count(1) record_id FROM DL_RECORDS WHERE record_id = :record_id"); 

		return queryResult.getResult().recordCount;
	}
}