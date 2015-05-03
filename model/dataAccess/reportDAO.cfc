component ReportDAO
{
	variables.instance = {
		datasource = '',
		queryHandler = ''
	};

	public ReportDAO function init(required dotlog.model.beans.datasource datasource)
	{
		variables.instance.queryHandler = new dotlog.model.queryHandler(arguments.datasource);
		return this;
	}

	public dotlog.model.beans.report function getLastReport(required string airportCode)
	{
		var queryHandler = new query();

		queryHandler.setName("fetchReportByAirportCode");

		sqlString = "SELECT * FROM ( SELECT * FROM DL_REPORTS ORDER BY report_id DESC ) WHERE ROWNUM <= 1";
		queryResult = variables.instance.queryHandler.executeQuery(queryHandler, sqlString);
		
		result = queryResult.getResult();
		
		lastReport = new dotlog.model.beans.report(username = result["username"][1],
													airportCode = result["airport_code"][1],
													beginDate = result["begin_date"][1],
													endDate = result["end_date"][1],
													recordID = result["report_id"][1]);
		return lastReport;

	}

	public boolean function saveReport(required dotlog.model.beans.report report)
	{
//		if ( reportExists(arguments.report) ) {
//			return updateReport(arguments.report);
//		} else { 
			return createReport(arguments.report);
//		} 
	}

	private boolean function updateReport(required dotlog.model.beans.report report)
	{
		var queryHandler = getQueryHandler("updateReport", arguments.report);

		sqlString = "UPDATE DL_REPORTS SET "
					& "DESCRIPTION = :description, ENABLED = :enabled, IN_WEEKLY_REPORT = :in_weekly_report "
					& "WHERE CATEGORY_TITLE = :report_title";
		queryResult = variables.instance.queryHandler.executeQuery(queryHandler, sqlString);
		return len(queryResult.getPrefix().recordCount);
	}

	private boolean function createReport(required dotlog.model.beans.report report)
	{
		var queryHandler = getQueryHandler("createReport", arguments.report);
		sqlString = "INSERT INTO DL_REPORTS "
					& "(username, airport_code, begin_date, end_date) "
					& "VALUES (:username, :airport_code, :begin_date, :end_date)";
		queryResult = variables.instance.queryHandler.executeQuery(queryHandler, sqlString);
		return len(queryResult.getPrefix().rowID); //returns a number - need to fix?
	}


/*
	private boolean function reportExists(required report report)
	{
		var queryHandler = getQueryHandler("doesReportExist", arguments.report);
		sqlString = "SELECT report_title "
					& "FROM DL_REPORTS "
					& "WHERE report_title = :report_title";
		queryResult = variables.instance.queryHandler.executeQuery(queryHandler, sqlString);
		return queryResult.getResult().recordCount;
	}
*/
	private base function getQueryHandler(required string queryName, required dotlog.model.beans.report report)
	{
		var queryHandler = new query();

		queryHandler.setName(arguments.queryName);

		//queryHandler.addParam(name = "report_id", value = arguments.report.isInWeeklyReport(), cfsqltype = "cf_sql_number");
		queryHandler.addParam(name = "username", value = arguments.report.getUsername(), cfsqltype = "cf_sql_varchar");
		queryHandler.addParam(name = "airport_code", value = arguments.report.getAirportCode(), cfsqltype = "cf_sql_varchar");
		queryHandler.addParam(name = "begin_date", value = arguments.report.getBeginDate(), cfsqltype = "cf_sql_date");
		queryHandler.addParam(name = "end_date", value = arguments.report.getEndDate(), cfsqltype = "cf_sql_date");

		return queryHandler;
	}
}