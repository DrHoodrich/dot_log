component reportServiceTests extends = "mxunit.framework.TestCase"
{
    DSName = "DOTlogDB";
    DSuser = " ";
    DSpasswd = " ";

    username = "test";
    beginDate = dateFormat(now(), 'yyyy-mm-dd');
    endDate = dateFormat(now(), 'yyyy-mm-dd');
    airportCode = "test";
    weeklyReport = 1;
    reportID = 556;
    
	public void function setUp()
	{
        datasource = new dotlog.model.beans.datasource(DSName, DSuser, DSpasswd);
        reportDAO = new dotlog.model.dataAccess.reportDAO(datasource);
        reportGW = new dotlog.model.dataAccess.reportGateway(datasource);
        
        testReportDAO = new dotlog.tests.server.DAOTestAdapter(reportDAO);
        testReportGW = new dotlog.tests.server.gatewayTestAdapter(reportGW);
        testReportService = new dotlog.model.service.reportService(datasource);

		testReport = new dotlog.model.beans.report(username = username,
                                                    airportCode = airportCode,
                                                    beginDate = beginDate,
                                                    weeklyReport = weeklyReport,
                                                    endDate = endDate);
	}

    public void function saveReport()
    {
        fail("TODO");
    }

    public void function getHubReports()
    {
        searchStruct = { airportCode = airportCode };
        resultFromGW = testReportGW.filter(searchStruct);
        resultFromService = testReportService.getHubReports(airportCode);

        assertEquals(resultFromGW, resultFromService);
    }

    public void function getLastReport()
    {
        searchStruct = { lastReport = '', airportCode = airportCode };
        resultFromGW = testReportGW.filter(searchStruct);
        resultFromService = testReportService.getLastReport(airportCode);

        assertEquals(resultFromGW[1], resultFromService);
    }
}
