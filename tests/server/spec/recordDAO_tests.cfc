component RecordDAOTests extends = "mxunit.framework.TestCase"
{
    DSName = "DOTlogDB";
    DSuser = " ";
    DSpasswd = " ";

	recordText = "Unit Test at " & now();
    username = "us";
    faaCode = "AUK";
    eventTime = CreateODBCDateTime( now() );
    recordTime = CreateODBCDateTime( now() );
    inWeeklyReport = 1;
    categoryTitle = "Fire";

	public void function setUp()
	{
        datasource = new dotlog.components.datasource(DSName, DSuser, DSpasswd);
		testRecord = new dotlog.components.record(recordText,
                                                username,
                                                faaCode,
                                                eventTime,
                                                recordTime,
                                                inWeeklyReport,
                                                categoryTitle);
	}

    public void function saveRecord()
    {
        testRecordDAO = new dotlog.components.recordDAO(datasource);
        assert(testRecordDAO.saveRecord(testRecord));
    }
}