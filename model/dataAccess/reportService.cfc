component ReportService
{
	variables.instance = {
		reportDAO = '',
		reportGW = ''
	};

	public reportService function init(required dotlog.model.beans.datasource datasource)
	{
		variables.instance.reportDAO = new dotlog.model.dataAccess.reportDAO(arguments.datasource);
		variables.instance.reportGW = new dotlog.model.dataAccess.reportGateway(arguments.datasource);
		return this;
	}

	public dotlog.model.beans.report function getLastReport(required string airportCode)
	{
		searchFilter = { lastReport = True, airportCode = airportCode };
		return variables.instance.reportDAO.search(searchFilter);
	}

	public boolean function saveReport(required dotlog.model.beans.report report)
	{
		return variables.instance.reportDAO.save(arguments.report);
	}

	public array function getHubReports(required string airportCode)
	{
		return variables.instance.reportGW.getHubReports(arguments.airportCode);
	}
}