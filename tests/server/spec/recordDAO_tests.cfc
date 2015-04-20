component RecordDAOTests extends = "mxunit.framework.TestCase"
{
    DSName = "DOTlogDB";
    DSuser = " ";
    DSpasswd = " ";

	recordText = "Unit Test at " & now();
    username = "us";
    airportCode = "AUK";
    eventTime = CreateODBCDateTime( now() );
    recordTime = CreateODBCDateTime( now() );
    inWeeklyReport = 1;
    categoryTitle = "Fire";

	public void function setUp()
	{
        datasource = new dotlog.model.beans.datasource(DSName, DSuser, DSpasswd);
		testRecord = new dotlog.model.beans.record(recordText,
                                                username,
                                                airportCode,
                                                eventTime,
                                                recordTime,
                                                inWeeklyReport,
                                                categoryTitle);
	}

    public void function saveRecord()
    {
        testRecordDAO = new dotlog.model.dataAccess.recordDAO(datasource);
        assert(testRecordDAO.saveRecord(testRecord));
    }
}