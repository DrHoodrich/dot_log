component RecordDAO extends = "dotlog.model.dataAccess.DAO"
{
	variables.queryHandler = '';

	public RecordDAO function init(required dotlog.model.beans.datasource datasource)
	{
		variables.queryHandler = new dotlog.model.queryHandler(arguments.datasource);
		return this;
	} 

	public boolean function save(required dotlog.model.beans.record record)
	{
		if ( record.getRecordID() ) {
			if ( recordExists(record) ) {
				return updateRecord(record);	
			}
			return createRecord(arguments.Record);
		} else { 
			return false;	
		} 
	}

	//Could just call the recordGW search function...
	public dotlog.model.beans.record function search(required struct searchFilter)
	{
		var userObjects = [];
		var queryService = new query();

		queryService.setName("fetchRecord");

		sqlStringRecords = "SELECT record_id, record_text, username, faa_code, event_time, record_time, in_weekly_report, category_id "
						& " FROM DL_RECORDS "
						& "WHERE 1 = 1 ";

		if ( !structIsEmpty(searchFilter) ) {
			if ( structKeyExists(searchFilter, "id") ) {
				queryService.addParam(name = "id", value = arguments.searchFilter.id, cfsqltype = "cf_sql_number");	
				sqlStringRecords &= " AND record_id = :id";
			}
		}

		var queryResult = variables.queryHandler.executeQuery(queryService, sqlStringRecords);
		var result = queryResult.getResult();

		var recordObject = '';
		if (result.RecordCount) {
			 recordObject = new dotlog.model.beans.record(recordText = result["record_text"][1],
							username = result["username"][1],
							airportCode = result["faa_code"][1],
							eventTime = result["event_time"][1],
							recordTime = result["record_time"][1],
							inWeeklyReport = result["in_weekly_report"][1],
							categoryID = result["category_id"][1],
							recordID = result["record_id"][1]);
		} else { 
			throw(message = "record does not exist");
		}
		return recordObject;
	}

	private boolean function recordExists(required dotlog.model.beans.record record)
	{		
		var queryHandler = getQueryHandler("doesRecordExist", arguments.record);
		sqlString = "SELECT record_id "
					& "FROM DL_RECORDS "
					& "WHERE record_id = :record_id";
		queryResult = variables.queryHandler.executeQuery(queryHandler, sqlString);		
		return queryResult.getResult().recordCount;
	}
	
	private boolean function createRecord(required dotlog.model.beans.record record)
	{
		var queryHandler = getQueryHandler("createRecord", arguments.record);

		sqlString = "INSERT INTO DL_RECORDS "
					& "(record_text, username, faa_code, event_time, record_time, in_weekly_report, category_id) "
					& "VALUES (:record_text, :username, :faa_code, :event_time, :record_time, :in_weekly_report, :category_id)";
		queryResult = variables.queryHandler.executeQuery(queryHandler, sqlString);
		return len(queryResult.getPrefix().rowID); //returns a number - need to fix?
	}

	private boolean function updateRecord(required dotlog.model.beans.record record)
	{
		var queryHandler = getQueryHandler("updateRecord", arguments.record);
		sqlString = "UPDATE DL_RECORDS SET "
					& "record_text = :record_text, faa_code = :faa_code, event_time = :event_time, in_weekly_report = :in_weekly_report, category_id = :category_id "
					& "WHERE record_id = :record_id";
		queryResult = variables.queryHandler.executeQuery(queryHandler, sqlString);
		return len(queryResult.getPrefix().recordCount);
	}

	private base function getQueryHandler(required string queryName, required dotlog.model.beans.record record)
	{
		var queryService = new query();

		queryService.setName(arguments.queryName);

		if ( record.getRecordID() ) {
			queryService.addParam(name = "record_id", value = arguments.record.getRecordID(), cfsqltype = "cf_sql_number");
		}
		queryService.addParam(name = "record_text", value = arguments.record.getRecordText(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "username", value = arguments.record.getUsername(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "faa_code", value = arguments.record.getAirportCode(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "event_time", value = arguments.record.getEventTime(), cfsqltype = "cf_sql_timestamp");
		queryService.addParam(name = "record_time", value = arguments.record.getRecordTime(), cfsqltype = "cf_sql_timestamp");
		queryService.addParam(name = "in_weekly_report", value = arguments.record.isInWeeklyReport(), cfsqltype = "cf_sql_number");
		queryService.addParam(name = "category_id", value = arguments.record.getCategoryID(), cfsqltype = "cf_sql_varchar");

		return queryService;
	}
}