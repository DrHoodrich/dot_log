component ReportGatewayTest extends = "mxunit.framework.TestCase"
{
    DSName = "DOTlogDB";
    DSuser = " ";
    DSpasswd = " ";

    username = "test";
    eventTime = createODBCTime( now() );
	airportCode = "test";
    isWeeklyReport = 1;
    reportID = 423;
    
	public void function setUp()
	{
        datasource = new dotlog.model.beans.datasource(DSName, DSuser, DSpasswd);     
        reportGW = new dotlog.model.dataAccess.reportGateway(datasource);
        testReportGW = new dotlog.tests.server.gatewayTestAdapter(reportGW);
	}

    public void function reportByReportID()
    {
        expected = 1;
        searchStruct = { reportID = reportID };
        actual = arrayLen(testReportGW.filter(searchStruct));
        assertEquals(expected, actual);
    }

    public void function reportsByUsername()
    {
        searchStruct = { username = username };
        reports = testReportGW.filter(searchStruct);
        assertTrue(arrayLen(reports));
    }

    public void function reportsByKeyword()
    {
        searchStruct = { keyword = username };
        reports = testReportGW.filter(searchStruct);
        assertTrue(arrayLen(reports));
    }

    public void function reportsByAirportCode()
    {
        searchStruct = { airportCode = airportCode };
        reports = testReportGW.filter(searchStruct);
        assertTrue(arrayLen(reports));
    }

    public void function reportsByDate()
    {
        searchStruct = { date = eventTime };
        reports = testReportGW.filter(searchStruct);
        assertTrue(arrayLen(reports));
    }

    public void function reportsByWeeklyReport()
    {
        searchStruct = { weeklyReport = isWeeklyReport };
        reports = testReportGW.filter(searchStruct);
        assertTrue(arrayLen(reports));
    }

    public void function reportsByDaterange()
    {
        searchStruct = { startDate = eventTime, endDate = now() };
        reports = testReportGW.filter(searchStruct);
        assertTrue(arrayLen(reports));
    }
    public void function allReports()
    {
        searchStruct = {};
        reports = testReportGW.filter(searchStruct);
        assertTrue(arrayLen(reports));
    }
}
