component RecordServiceTests extends = "mxunit.framework.TestCase"
{
    DSName = "DOTlogDB";
    DSuser = " ";
    DSpasswd = " ";

	recordText = "Unit Test at " & now();
    username = "test";
    airportCode = "test";
    eventTime = CreateODBCDateTime( now() );
    recordTime = CreateODBCDateTime( now() );
    inWeeklyReport = 1;
    categoryID = 428;

	public void function setUp()
	{
        datasource = new dotlog.model.beans.datasource(DSName, DSuser, DSpasswd);
        recordDAO = new dotlog.model.dataAccess.recordDAO(datasource);
        recordGW = new dotlog.model.dataAccess.recordGateway(datasource);
        
        testRecordDAO = new dotlog.tests.server.DAOTestAdapter(recordDAO);
        testRecordGW = new dotlog.tests.server.gatewayTestAdapter(recordGW);
        testRecordService = new dotlog.model.service.recordService(testRecordDAO, testRecordGW);

		testRecord = new dotlog.model.beans.record(recordText,
                                                username,
                                                airportCode,
                                                eventTime,
                                                recordTime,
                                                inWeeklyReport,
                                                categoryID);
	}

    public void function recordByID()
    {
        recordID = 669; // TODO: find a good way to get a value that exists from database, wrap an insert into a transaction?

        searchStruct = { recordID = recordID };
        
        resultFromService = testRecordService.getRecordByID(searchStruct.recordID);
        resultFromGW = testRecordGW.filter(searchStruct);

        assertEquals(resultFromService.getRecordText(), resultFromGW[1].getRecordText());
    }

    public void function recordsByAirportCode()
    {
        var airportCode = "test";
        searchStruct = { airportCode = airportCode };

        resultFromGW = testRecordGW.filter(searchStruct);
        resultFromService = testRecordService.getRecordsByAirportCode(airportCode);

        assertEquals(resultFromGW, resultFromService);
    }

    public void function getRecordsAfterDate()
    {
        fail("Todo");
    }

    public void function search()
    {
        var airportCode = "test";

        searchStruct = { airportCode = airportCode, username = username };
        resultFromGW = testRecordGW.filter(searchStruct);
        resultFromService = testRecordService.search(searchStruct);

        assertEquals(resultFromGW, resultFromService);
    }

    public void function saveRecord()
    {
        assertTrue(testRecordService.saveRecord(testRecord) && testRecordDAO.save(testRecord));
    }
}
