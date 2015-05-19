component userServiceTests extends = "mxunit.framework.TestCase"
{
    DSName = "DOTlogDB";
    DSuser = " ";
    DSpasswd = " ";

    username = "test";
    firstName = "Bob";
    lastName = "Dylan";
    airportCode = "AUK";
    permissions = "1";
    enabled = "1";
    districtManager = 1;
    regionManager = 1;
    emailAddr = "test";
    
	public void function setUp()
	{
        datasource = new dotlog.model.beans.datasource(DSName, DSuser, DSpasswd);
        userDAO = new dotlog.model.dataAccess.userDAO(datasource);
        userGW = new dotlog.model.dataAccess.userGateway(datasource);
        
        testUserDAO = new dotlog.tests.server.DAOTestAdapter(userDAO);
        testUserGW = new dotlog.tests.server.gatewayTestAdapter(userGW);
        testUserService = new dotlog.model.service.userService(datasource);

        testUser = new dotlog.model.beans.user(username,
                                                firstName,
                                                lastName,
                                                airportCode,
                                                permissions,
                                                enabled,
                                                districtManager,
                                                regionManager,
                                                emailAddr);
	}

    public void function saveUser()
    {
        fail("TODO");
    }

    public void function getUsersByAirportCode()
    {
        searchStruct = { airportCode = airportCode };

        resultFromGW = testUserGW.filter(searchStruct);
        resultFromService = testUserService.getUsersByAirportCode(airportCode);

        assertEquals(resultFromGW, resultFromService);
    }

    public void function getUserByUsername()
    {
        searchStruct = { username = username };
        resultFromGW = testUserGW.filter(searchStruct);
        resultFromService = testUserService.getUserByUsername(username);

        assertEquals(resultFromGW[1], resultFromService);
    }
}
