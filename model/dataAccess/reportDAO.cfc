component ReportDAO extends = "dotlog.model.dataAccess.DAO"
{
	variables.queryHandler = '';

	public ReportDAO function init(required dotlog.model.beans.datasource datasource)
	{
		variables.queryHandler = new dotlog.model.queryHandler(arguments.datasource);
		return this;
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
		queryHandler.addParam(name = "reportID", value = arguments.report.getReportID(), cfsqltype = "cf_sql_number");
		sqlString = "UPDATE DL_REPORTS SET "
					& "username = :username, airport_code = :airportCode, begin_date = :beginDate, end_date = :endDate, weekly_report = :weeklyReport "
					& "WHERE report_id = :reportID";
		queryResult = variables.queryHandler.executeQuery(queryHandler, sqlString);
		return len(queryResult.getPrefix().recordCount);
	}

	private boolean function createReport(required dotlog.model.beans.report report)
	{
		var queryHandler = getQueryHandler("createReport", arguments.report);
		sqlString = "INSERT INTO DL_REPORTS "
					& "(username, airport_code, begin_date, end_date, weekly_report) "
					& "VALUES (:username, :airportCode, :beginDate, :endDate, :weeklyReport)";
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
		queryHandler.addParam(name = "airportCode", value = arguments.report.getAirportCode(), cfsqltype = "cf_sql_varchar");
		queryHandler.addParam(name = "beginDate", value = arguments.report.getBeginDate(), cfsqltype = "cf_sql_date");
		queryHandler.addParam(name = "endDate", value = arguments.report.getEndDate(), cfsqltype = "cf_sql_date");
		queryHandler.addParam(name = "weeklyReport", value = arguments.report.isWeeklyReport(), cfsqltype = "cf_sql_number");

		return queryHandler;
	}
}