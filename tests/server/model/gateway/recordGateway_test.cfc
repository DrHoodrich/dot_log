component RecordGatewayTest extends = "mxunit.framework.TestCase"
{
    DSName = "DOTlogDB";
    DSuser = " ";
    DSpasswd = " ";

	recordText = "test";
    username = "test";
    airportCode = "test";
    eventTime = CreateODBCDateTime( now() );
    recordTime = CreateODBCDateTime( now() );
    inWeeklyReport = 1;
    categoryID = 428;

	public void function setUp()
	{
        datasource = new dotlog.model.beans.datasource(DSName, DSuser, DSpasswd);     
        recordGW = new dotlog.model.dataAccess.recordGateway(datasource);
        testRecordGW = new dotlog.tests.server.gatewayTestAdapter(recordGW);
	}

    public void function recordsByUsername()
    {
        searchStruct = { username = username };
        records = testRecordGW.filter(searchStruct);
        assertTrue(arrayLen(records));
    }

    public void function recordsByKeyword()
    {
        searchStruct = { keyword = username };
        records = testRecordGW.filter(searchStruct);
        assertTrue(arrayLen(records));
    }

    public void function recordsByCategoryID()
    {
        searchStruct = { categoryID = categoryID };
        records = testRecordGW.filter(searchStruct);
        assertTrue(arrayLen(records));
    }

    public void function recordsByAirportCode()
    {
        searchStruct = { airportCode = airportCode };
        records = testRecordGW.filter(searchStruct);
        assertTrue(arrayLen(records));
    }

    public void function recordsByDate()
    {
        searchStruct = { date = eventTime };
        records = testRecordGW.filter(searchStruct);
        assertTrue(arrayLen(records));
    }

    public void function recordsByInWeeklyReport()
    {
        searchStruct = { included = inWeeklyReport };
        records = testRecordGW.filter(searchStruct);
        assertTrue(arrayLen(records));
    }

    public void function recordsByDaterange()
    {
        searchStruct = { startDate = eventTime, endDate = now() };
        records = testRecordGW.filter(searchStruct);
        assertTrue(arrayLen(records));
    }

    public void function allRecords()
    {
        searchStruct = {};
        records = testRecordGW.filter(searchStruct);
        assertTrue(arrayLen(records));
    }
}
