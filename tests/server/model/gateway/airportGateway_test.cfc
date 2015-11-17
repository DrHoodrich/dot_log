component AirportGatewayTest extends = "mxunit.framework.TestCase"
{
    DSName = "DOTlogDB";
    DSuser = " ";
    DSpasswd = " ";

    airportCode = "test";
    hubCode = "test";
    airportName = "test";    
    isEnabled = 1;
    districtID = 93;
        
	public void function setUp()
	{
        datasource = new dotlog.model.beans.datasource(DSName, DSuser, DSpasswd);     
        airportGW = new dotlog.model.dataAccess.airportGateway(datasource);
        testAirportGW = new dotlog.tests.server.gatewayTestAdapter(airportGW);
	}

    public void function airportByAirportCode()
    {
        expected = 1;
        searchStruct = { airportCode = airportCode };
        actual = arrayLen(testAirportGW.filter(searchStruct));
        assertEquals(expected, actual);
    }

    public void function airportsByHubCode()
    {
        searchStruct = { hubCode = hubCode };
        airports = testAirportGW.filter(searchStruct);
        assertTrue(arrayLen(airports));
    }

    public void function airportByName()
    {
        searchStruct = { airportName = airportName };
        airports = testAirportGW.filter(searchStruct);
        assertTrue(arrayLen(airports));
    }

    public void function airportByDistrictID()
    {
        searchStruct = { districtID = districtID };
        airports = testAirportGW.filter(searchStruct);
        assertTrue(arrayLen(airports));
    }

    public void function enabledAirports()
    {
        searchStruct = { enabled = isEnabled };
        airports = testAirportGW.filter(searchStruct);
        assertTrue(arrayLen(airports));
    }

    public void function allAirports()
    {
        searchStruct = {};
        airports = testAirportGW.filter(searchStruct);
        assertTrue(arrayLen(airports));
    }
}
