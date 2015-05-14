component RecordServiceTests extends = "mxunit.framework.TestCase"
{
    DSName = "DOTlogDB";
    DSuser = " ";
    DSpasswd = " ";

	recordText = "Unit Test at " & now();
    username = "Administrator";
    airportCode = "AFM";
    eventTime = CreateODBCDateTime( now() );
    recordTime = CreateODBCDateTime( now() );
    inWeeklyReport = 1;
    categoryTitle = "Fire";

	public void function setUp()
	{
        datasource = new dotlog.model.beans.datasource(DSName, DSuser, DSpasswd);
        recordDAO = new dotlog.model.dataAccess.recordDAO(datasource);
        recordGW = new dotlog.model.dataAccess.recordGateway(datasource);
        
        testRecordDAO = new dotlog.tests.server.DAOTestAdapter(recordDAO);
        testRecordGW = new dotlog.tests.server.gatewayTestAdapter(recordGW);
        testRecordService = new dotlog.model.service.recordService(datasource);

		testRecord = new dotlog.model.beans.record(recordText,
                                                username,
                                                airportCode,
                                                eventTime,
                                                recordTime,
                                                inWeeklyReport,
                                                categoryTitle);
	}

    public void function recordByID()
    {
        recordID = 655; // TODO: find a good way to get a value that exists from database, wrap an insert into a transaction?

        searchStruct = { id = recordID };
        
        resultFromService = testRecordService.getRecordByID(searchStruct.id);
        resultFromDAO = testRecordDAO.search(searchStruct);

        assertEquals(resultFromService.getRecordText(), resultFromDAO.getRecordText());
    }

    public void function recordsByAirportCode()
    {
        var airportCode = "test";
        searchStruct = { airportCode = airportCode };

        resultFromGW = testRecordGW.filter(searchStruct);
        resultFromService = testRecordService.getRecordsByAirportCode(airportCode);

        assertEquals(resultFromGW, resultFromService);
    }
}
