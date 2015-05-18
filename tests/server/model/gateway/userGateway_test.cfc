component userGatewayTest extends = "mxunit.framework.TestCase"
{
    DSName = "DOTlogDB";
    DSuser = " ";
    DSpasswd = " ";

    username = "test";
    firstName = "testFirst";
    lastName = "testLast";
    eventTime = createODBCTime( now() );
	airportCode = "test";
    emailAddr = ".edu";
    isAdmin = 1;
    regionManager = 1;
    isEnabled = 1;
    districtManager = 1;
        
	public void function setUp()
	{
        datasource = new dotlog.model.beans.datasource(DSName, DSuser, DSpasswd);     
        userGW = new dotlog.model.dataAccess.userGateway(datasource);
        testUserGW = new dotlog.tests.server.gatewayTestAdapter(userGW);
	}

    public void function userByUsername()
    {
        expected = 1;
        searchStruct = { username = username };
        actual = arrayLen(testUserGW.filter(searchStruct));
        assertEquals(expected, actual);
    }

    public void function usersByFirstName()
    {
        searchStruct = { firstName = firstName };
        users = testUserGW.filter(searchStruct);
        assertTrue(arrayLen(users));
    }

    public void function usersByLastName()
    {
        searchStruct = { keyword = lastName };
        users = testUserGW.filter(searchStruct);
        assertTrue(arrayLen(users));
    }

    public void function usersByAirportCode()
    {
        searchStruct = { airportCode = airportCode };
        users = testUserGW.filter(searchStruct);
        assertTrue(arrayLen(users));
    }

    public void function usersByPermissions()
    {
        searchStruct = { permission = isAdmin };
        users = testUserGW.filter(searchStruct);
        assertTrue(arrayLen(users));
    }

    public void function usersByStatus()
    {
        searchStruct = { enabled = isEnabled };
        users = testUserGW.filter(searchStruct);
        assertTrue(arrayLen(users));
    }

    public void function usersByEmail()
    {
        searchStruct = { weeklyReport = emailAddr };
        users = testUserGW.filter(searchStruct);
        assertTrue(arrayLen(users));
    }

    public void function regionManagerUsers()
    {
        searchStruct = { regionManager = regionManager };
        users = testUserGW.filter(searchStruct);
        assertTrue(arrayLen(users));
    }

    public void function districtManagerUsers()
    {
        searchStruct = { districtManager = districtManager };
        users = testUserGW.filter(searchStruct);
        assertTrue(arrayLen(users));
    }

    public void function allUsers()
    {
        searchStruct = {};
        users = testUserGW.filter(searchStruct);
        assertTrue(arrayLen(users));
    }
}
