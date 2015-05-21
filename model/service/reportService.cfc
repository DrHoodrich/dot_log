component ReportService
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
		var report = '';
		var searchFilter = { lastReport = '', airportCode = arguments.airportCode };
		var result = variables.instance.reportGW.filter(searchFilter);
		if ( arrayLen(result) ) {
			report = result[1];
		}
		return report;
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
}