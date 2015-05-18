component RecordGateway extends = "dotlog.model.dataAccess.gateway"
{
	variables.queryHandler = '';

	public RecordGateway function init(required dotlog.model.beans.datasource datasource)
	{
		variables.queryHandler = new dotlog.model.queryHandler(arguments.datasource);
		return this;
	}

	public array function filter(required struct searchFilter)
	{
		var queryService = new query();
		queryService.setName("fetchRecords");

		sqlStringRecords = "SELECT record_id, record_text, username, faa_code, event_time, record_time, in_weekly_report, category_id "
						& " FROM DL_RECORDS "
						& " WHERE 1 = 1 ";

		if ( !structIsEmpty(searchFilter) ) {
			if ( structKeyExists(searchFilter, "username") ) {
				queryService.addParam(name = "username", value = "%"&arguments.searchFilter.username&"%", cfsqltype = "cf_sql_varchar");	
				sqlStringRecords &= " AND username LIKE :username";
			} 
			if ( structKeyExists(searchFilter, "keyword") ) {
				queryService.addParam(name = "keyword", value = "%"&arguments.searchFilter.keyword&"%", cfsqltype = "cf_sql_varchar");	
				sqlStringRecords &= " AND LOWER(record_text) LIKE LOWER(:keyword)";
			}
			if ( structKeyExists(searchFilter, "categoryID") ) {
				queryService.addParam(name = "category_id", value = arguments.searchFilter.categoryID, cfsqltype = "cf_sql_number");	
				sqlStringRecords &= " AND category_id = :category_id";
			}
			if ( structKeyExists(searchFilter, "airportCode") ) {
				queryService.addParam(name = "faa_code", value = "%"&arguments.searchFilter.airportCode&"%", cfsqltype = "cf_sql_varchar");	
				sqlStringRecords &= " AND LOWER(faa_code) LIKE LOWER(:faa_code)";
			}
			if ( structKeyExists(searchFilter, "date") ) {
				queryService.addParam(name = "date", value = arguments.searchFilter.date, cfsqltype = "cf_sql_timestamp");	
				sqlStringRecords &= " AND record_time >= :date";
			}
			if ( structKeyExists(searchFilter, "included") ) {
				queryService.addParam(name = "included", value = arguments.searchFilter.included, cfsqltype = "cf_sql_number");	
				sqlStringRecords &= " AND in_weekly_report = :included";
			}
			if ( structKeyExists(searchFilter,"startDate") && structKeyExists(searchFilter,"endDate") ) {
				queryService.addParam(name = "startDate", value = arguments.searchFilter.startDate, cfsqltype = "cf_sql_timestamp");
				queryService.addParam(name = "endDate", value = dateAdd("d", 1, arguments.searchFilter.endDate), cfsqltype = "cf_sql_timestamp");
				sqlStringRecords &= " AND event_time >= :startDate";
				sqlStringRecords &= " AND event_time <= :endDate";
			}
		}

		var queryResult = variables.queryHandler.executeQuery(queryService, sqlStringRecords);
		var result = queryResult.getResult();

		var recordObjects = [];
		for (var ii = 1; ii <= result.RecordCount; ++ii) {
			 recordObject = new dotlog.model.beans.record(recordText = result["record_text"][ii],
							username = result["username"][ii],
							airportCode = result["faa_code"][ii],
							eventTime = result["event_time"][ii],
							recordTime = result["record_time"][ii],
							inWeeklyReport = result["in_weekly_report"][ii],
							categoryID = result["category_id"][ii],
							recordID = result["record_id"][ii]);
			 arrayAppend(recordObjects, recordObject);
		}
		return recordObjects;
	}
}