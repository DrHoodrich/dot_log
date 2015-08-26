component ReportService extends = "dotlog.model.service.service"
{
	variables.instance = {
		reportDAO = '',
		reportGW = ''
	};

	public reportService function init(required dotlog.model.dataAccess.DAO DAO,
										required dotlog.model.dataAccess.gateway GW)
	{
		variables.instance.reportDAO = arguments.DAO;
		variables.instance.reportGW = arguments.GW;
		return this;
	}

	public dotlog.model.beans.report function getLastReport(required string airportCode)
	{
		var searchFilter = { lastReport = '', airportCode = arguments.airportCode };
		return fetchReport(searchFilter);
	}

	public dotlog.model.beans.report function getLastWeeklyReport(required string airportCode)
	{
		var searchFilter = { lastReport = '', airportCode = arguments.airportCode, weeklyReport = '1' };
		return fetchReport(searchFilter);
	}

	public boolean function saveReport(required dotlog.model.beans.report report)
	{
		return variables.instance.reportDAO.save(arguments.report);
	}

	public array function getHubReports(required string airportCode)
	{
		searchFilter = { airportCode = arguments.airportCode };
		return variables.instance.reportGW.filter(searchFilter);
	}

	private dotlog.model.beans.report function fetchReport(required struct searchFilter)
	{
		var report = '';
		var result = variables.instance.reportGW.filter(arguments.searchFilter);
		if ( arrayLen(result) ) {
			report = result[1];
		} else {
			throw (message = "No record found.");
		}
		return report;
	}
}