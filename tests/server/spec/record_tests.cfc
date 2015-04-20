component userTest extends = "mxunit.framework.TestCase" {
	recordText = "Some event";
    username = "tester";
    airportCode = "AUK";
    eventTime = CreateODBCDateTime( now() );
    recordTime = CreateODBCDateTime( now() );
    inWeeklyReport = 1;
    categoryTitle = "Fire";

	public void function setUp()
	{
		testRecord = new dotlog.model.beans.record(recordText,
                                                    username,
                                                    airportCode,
                                                    eventTime,
                                                    recordTime,
                                                    inWeeklyReport,
                                                    categoryTitle);
	}

	public void function getRecordText()
	{
		expected = recordText;
		actual = testRecord.getRecordText();
		assertEquals(expected, actual);
	}

    public void function getUsername() 
    {
    	expected = username;
    	actual = testRecord.getUsername();
    	assertEquals(expected, actual);
    }

    public void function getAirportCode()
    {
		expected = airportCode;
		actual = testRecord.getAirportCode();
		assertEquals(expected, actual);
    }

    public void function getEventTime()
    {
    	expected = eventTime;
    	actual = testRecord.getEventTime();
    	assertEquals(expected, actual);
    }

    public void function isInWeeklyReport()
    {
        assert(testRecord.isInWeeklyReport());
    }

    public void function getRecordTime()
    {
        expected = recordTime;
        actual = testRecord.getRecordTime();
        assertEquals(expected, actual);
    }

    public void function getCategory()
    {
        expected = categoryTitle;
        actual = testRecord.getCategory();
        assertEquals(expected, actual);
    }
}