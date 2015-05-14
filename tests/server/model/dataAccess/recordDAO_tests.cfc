component RecordDAOTests extends = "mxunit.framework.TestCase"
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
    categoryTitle = "Fire";

	public void function setUp()
	{
        datasource = new dotlog.model.beans.datasource(DSName, DSuser, DSpasswd);
        recordDAO = new dotlog.model.dataAccess.recordDAO(datasource);
		testRecord = new dotlog.model.beans.record(recordText,
                                                username,
                                                airportCode,
                                                eventTime,
                                                recordTime,
                                                inWeeklyReport,
                                                categoryTitle);
	}

    public void function createNewRecord()
    {
        testRecordDAO = new dotlog.tests.server.DAOTestAdapter(recordDAO);
        assertTrue(testRecordDAO.save(testRecord), "Return true on seccessful insert.");
    }

    public void function greaterThan4000CharEntry()
    {
        while (len(recordText) < 4000) {
            recordText &= "aaaaaaaaaaaaaaaaaaa";
        }

        testRecord = new dotlog.model.beans.record(recordText,
                                                username,
                                                airportCode,
                                                eventTime,
                                                recordTime,
                                                inWeeklyReport,
                                                categoryTitle);
        testRecordDAO = new dotlog.tests.server.DAOTestAdapter(recordDAO);

        try {
            testRecordDAO.save(testRecord);
        } catch (database expt) {
            if (find('can bind a LONG value only for insert into a LONG column', expt.RootCause.message)) {
                //Give message for summery is too long.
            } else { 
                rethrow;
            }
        }
        assertTrue(true, "Handled expection.");
    }
}