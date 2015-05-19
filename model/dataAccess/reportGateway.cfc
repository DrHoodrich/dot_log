component ReportGateway extends = "dotlog.model.dataAccess.gateway"
{
	variables.queryHandler = '';
	
	public reportGateway function init(required dotlog.model.beans.datasource datasource)
	{
		variables.queryHandler = new dotlog.model.queryHandler(arguments.datasource);
		return this;
	}

	public array function filter(struct searchFilter=structNew())
	{
		var queryService = new query();

		var sqlString = " SELECT report_id, username, airport_code, begin_date, end_date, weekly_report "
						& " FROM DL_REPORTS "
						& " WHERE 1 = 1 ";

		if ( !structIsEmpty(searchFilter) ) {
			queryService.setName("filterReports");
			if ( structKeyExists(searchFilter, "reportID") ) {
				queryService.addParam(name = "reportID", value = arguments.searchFilter.reportID, cfsqltype = "cf_sql_number");
				sqlString &= " AND report_id = :reportID";
			}
			if ( structKeyExists(searchFilter, "username") ) {
				queryService.addParam(name = "username", value = arguments.searchFilter.username, cfsqltype = "cf_sql_varchar");
				sqlString &= " AND username = :username";
			}
			if ( structKeyExists(searchFilter, "airportCode") ) {
				queryService.addParam(name = "airportCode", value = arguments.searchFilter.airportCode, cfsqltype = "cf_sql_varchar");
				sqlString &= " AND airport_code = :airportCode";
			}
			if ( structKeyExists(searchFilter, "date") ) {
				queryService.addParam(name = "date", value = arguments.searchFilter.date, cfsqltype = "cf_sql_timestamp");
				sqlString &= " AND begin_date >= :date";
			}
			if ( structKeyExists(searchFilter,"startDate") && structKeyExists(searchFilter,"endDate") ) {
				queryService.addParam(name = "startDate", value = arguments.searchFilter.startDate, cfsqltype = "cf_sql_timestamp");
				queryService.addParam(name = "endDate", value = dateAdd("d", 1, arguments.searchFilter.endDate), cfsqltype = "cf_sql_timestamp");
				sqlString &= " AND begin_date >= :startDate";
				sqlString &= " AND end_date <= :endDate";
			}
			if ( structKeyExists(searchFilter, "weeklyReport") ) {
				queryService.addParam(name = "weeklyReport", value = arguments.searchFilter.weeklyReport, cfsqltype = "cf_sql_number");	
				sqlString &= " AND weekly_report = :weeklyReport";
			}
			if ( structKeyExists(arguments.searchFilter, "lastReport") ) {
				if ( structKeyExists(arguments.searchFilter, "airportCode") ) {
					sqlString = "SELECT report_id, username, airport_code, begin_date, end_date, weekly_report "
								& " FROM ( SELECT report_id, username, airport_code, begin_date, end_date, weekly_report "
									   & " FROM DL_REPORTS "
									   & " ORDER BY report_id DESC ) " 
	                            & " WHERE ROWNUM <= 1";
	            }
			}
		} else {
			queryService.setName("getAllReports");
		}

		var queryResult = queryHandler.executeQuery(queryService, sqlString);
		result = queryResult.getResult();
		
		var reports = [];
		for (var ii = 1; ii <= result.RecordCount; ++ii) {
			 report = new dotlog.model.beans.report(username = result["username"][ii],
													airportCode = result["airport_code"][ii],
													beginDate = result["begin_date"][ii],
													endDate = result["end_date"][ii],
													reportID = result["report_id"][ii],
													weeklyReport = result["weekly_report"][ii]);
			 arrayAppend(reports, report);
		}
		return reports;
	}
}