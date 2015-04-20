component ReportGateway
{
	variables.instance = {
		datasource = ''
	};

	public reportGateway function init(required dotlog.model.beans.datasource datasource)
	{
		variables.instance.datasource = arguments.datasource;
		return this;
	}

	public array function getHubReports(required string airportCode)
	{
		DSname = variables.instance.datasource.getDSName();
		DSusername = variables.instance.datasource.getUsername();
		DSpassword = variables.instance.datasource.getPassword();

		var queryService = new query();

		queryService.setName("fetchHubReports");
	
		queryService.setDataSource(DSName);
		queryService.setUsername(DSusername);
		queryService.setPassword(DSpassword);

		queryService.addParam(name = "airport_code", value = arguments.airportCode, cfsqltype = "cf_sql_varchar");

		queryResult = queryService.execute(sql = "SELECT * FROM ( SELECT report_id, username, AIRPORT_CODE, begin_date, end_date
			FROM DL_REPORTS WHERE airport_code = :airport_code ORDER BY end_date DESC ) WHERE ROWNUM <= 10");
		result = queryResult.getResult();

		
		var reports = [];
		for (var ii = 1; ii <= result.RecordCount; ++ii) {
			 report = new dotlog.model.beans.report(username = result["username"][ii],
													airportCode = result["airport_code"][ii],
													beginDate = result["begin_date"][ii],
													endDate = result["end_date"][ii],
													reportID = result["report_id"][ii]);
			 arrayAppend(reports, report);
		}
		return reports;
	}
}