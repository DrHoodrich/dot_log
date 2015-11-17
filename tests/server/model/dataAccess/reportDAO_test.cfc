component ReportDAOTests extends = "mxunit.framework.TestCase"
{
	DSName = "DOTlogDB";
	DSuser = " ";
	DSpasswd = " ";

	username = "test";
    beginDate = dateFormat(now(), 'yyyy-mm-dd');
    endDate = dateFormat(now(), 'yyyy-mm-dd');
    airportCode = "test";
    weeklyReport = 1;

	public void function setUp()
	{
		datasource = new dotlog.model.beans.datasource(DSName, DSuser, DSpasswd);
		reportDAO = new dotlog.model.dataAccess.reportDAO(datasource);
		testReportDAO = new dotlog.tests.server.DAOTestAdapter(reportDAO);
		testReport = new dotlog.model.beans.report(username = username,
                                            airportCode = airportCode,
                                            beginDate = beginDate,
                                            weeklyReport = weeklyReport,
                                            endDate = endDate);
	}

	public void function reportDAOConstruction()
	{		
		assertSame(reportDAO, reportDAO.init(datasource));
	}

	public void function reportDAOCreateReport()
	{
		assertTrue(testReportDAO.save(testReport));
	}

	public void function updateReport()
	{
	    assertTrue(testReportDAO.save(testReport));
	}
}