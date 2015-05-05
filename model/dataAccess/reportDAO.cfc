component ReportDAO extends = "dotlog.model.dataAccess.DAO"
{
	variables.queryHandler = '';

	public ReportDAO function init(required dotlog.model.beans.datasource datasource)
	{
		variables.queryHandler = new dotlog.model.queryHandler(arguments.datasource);
		return this;
	}

	public dotlog.model.beans.report function search(required struct searchFilter)
	{
		var queryHandler = new query();

		queryHandler.setName("fetchReportByAirportCode");

		sqlString = "SELECT report_id, username, airport_code, begin_date, end_date " 
					& " WHERE 1 = 1";

		if ( structKeyExists(arguments.searchFilter, "lastReport") ) {
			if ( structKeyExists(arguments.searchFilter, "airportCode") ) {
				sqlString = "SELECT report_id, username, airport_code, begin_date, end_date "
							& " FROM ( SELECT report_id, username, airport_code, begin_date, end_date "
								   & " FROM DL_REPORTS "
								   & " ORDER BY report_id DESC ) " 
                            & " WHERE ROWNUM <= 1";	
			}
		}

		var queryResult = variables.queryHandler.executeQuery(queryHandler, sqlString);
		var result = queryResult.getResult();
		var report = new dotlog.model.beans.report(username = result["username"][1],
													airportCode = result["airport_code"][1],
													beginDate = result["begin_date"][1],
													endDate = result["end_date"][1],
													recordID = result["report_id"][1]);
		return report;
	}

	public boolean function save(required dotlog.model.beans.report report)
	{
		if ( reportExists(arguments.report) ) {
			return updateReport(arguments.report);
		} else { 
			return createReport(arguments.report);
		} 
	}

	private boolean function updateReport(required dotlog.model.beans.report report)
	{
		var queryHandler = getQueryHandler("updateReport", arguments.report);
		queryHandler.addParam(name = "report_id", value = arguments.report.getReportID(), cfsqltype = "cf_sql_number");
		sqlString = "UPDATE DL_REPORTS SET "
					& "DESCRIPTION = :description, ENABLED = :enabled, IN_WEEKLY_REPORT = :in_weekly_report "
					& "WHERE report_id = :report_id";
		queryResult = variables.queryHandler.executeQuery(queryHandler, sqlString);
		return len(queryResult.getPrefix().recordCount);
	}

	private boolean function createReport(required dotlog.model.beans.report report)
	{
		var queryHandler = getQueryHandler("createReport", arguments.report);
		sqlString = "INSERT INTO DL_REPORTS "
					& "(username, airport_code, begin_date, end_date) "
					& "VALUES (:username, :airport_code, :begin_date, :end_date)";
		queryResult = variables.queryHandler.executeQuery(queryHandler, sqlString);
		return len(queryResult.getPrefix().rowID); //returns a number - need to fix?
	}

	private boolean function reportExists(required dotlog.model.beans.report report)
	{
		var queryHandler = getQueryHandler("doesReportExist", arguments.report);
		queryHandler.addParam(name = "report_id", value = arguments.report.getReportID(), cfsqltype = "cf_sql_number");
		sqlString = "SELECT report_id "
					& "FROM DL_REPORTS "
					& "WHERE report_id = :report_id";
		queryResult = variables.queryHandler.executeQuery(queryHandler, sqlString);
		return queryResult.getResult().recordCount;
	}

	private base function getQueryHandler(required string queryName, required dotlog.model.beans.report report)
	{
		var queryHandler = new query();

		queryHandler.setName(arguments.queryName);
		queryHandler.addParam(name = "username", value = arguments.report.getUsername(), cfsqltype = "cf_sql_varchar");
		queryHandler.addParam(name = "airport_code", value = arguments.report.getAirportCode(), cfsqltype = "cf_sql_varchar");
		queryHandler.addParam(name = "begin_date", value = arguments.report.getBeginDate(), cfsqltype = "cf_sql_date");
		queryHandler.addParam(name = "end_date", value = arguments.report.getEndDate(), cfsqltype = "cf_sql_date");

		return queryHandler;
	}
}