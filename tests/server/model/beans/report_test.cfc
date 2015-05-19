component ReportTest extends = "mxunit.framework.TestCase" 
{
	username = "tester";
    beginDate = dateFormat(now(), 'yyyy-mm-dd');
    endDate = dateFormat(now(), 'yyyy-mm-dd');
    airportCode = "Statewide";
    weeklyReport = 1;

	public void function setUp()
	{
		testReport = new dotlog.model.beans.report(username = username,
                                                    airportCode = airportCode,
                                                    beginDate = beginDate,
                                                    weeklyReport = weeklyReport,
                                                    endDate = endDate);
	}

	public void function uninitializedReportID()
	{
		expectedReportID = -1;
		actualReportID = testReport.getReportID();
		assertEquals(expectedReportID, actualReportID);
	}

    public void function initilizedReporID()
    {
        expectedReportID = 1337;
        testReport = new dotlog.model.beans.report(username = username,
                                            airportCode = airportCode,
                                            beginDate = beginDate,
                                            endDate = endDate,
                                            weeklyReport = weeklyReport,
                                            reportID = expectedReportID);
        
        actualReportID = testReport.getReportID();
        assertEquals(expectedReportID, actualReportID);

    }

    public void function getUsername()
    {
        expected = username;
        actual = testReport.getUsername();
        assertEquals(expected, actual);
    }

    public void function getAirportCode()
    {
        expected = airportCode;
        actual = testReport.getAirportCode();
        assertEquals(expected, actual);
    }

    public void function getBeginDate()
    {
        expected = beginDate;
        actual = testReport.getBeginDate();
        assertEquals(expected, actual);
    }

    public void function getEndDate()
    {
        expected = endDate;
        actual = testReport.getEndDate();
        assertEquals(expected, actual);
    }
    
}