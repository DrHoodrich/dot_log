component AirportServiceTests extends = "mxunit.framework.TestCase"
{
    DSName = "DOTlogDB";
    DSuser = " ";
    DSpasswd = " ";

    AirportCode = "test";
    hubCode = "test";
    airportName = "test";
    districtID = 93;
    enabled = 1;

	public void function setUp()
	{
        datasource = new dotlog.model.beans.datasource(DSName, DSuser, DSpasswd);
        airportDAO = new dotlog.model.dataAccess.airportDAO(datasource);
        airportGW = new dotlog.model.dataAccess.airportGateway(datasource);
        
        testAirportDAO = new dotlog.tests.server.DAOTestAdapter(airportDAO);
        testAirportGW = new dotlog.tests.server.gatewayTestAdapter(airportGW);
        testAirportService = new dotlog.model.service.airportService(testAirportDAO, testAirportGW);

		testAirport = new dotlog.model.beans.airport(AirportCode,
                                                    hubCode,
                                                    airportName,
                                                    districtID,
                                                    enabled);
	}

    public void function saveAirport()
    {
        assertTrue(testAirportService.saveAirport(testAirport) && testAirportDAO.save(testAirport));
    }

    public void function getSpokeAirports()
    {
        searchStruct = { hubCode = hubCode };

        resultFromGW = testAirportGW.filter(searchStruct);
        resultFromService = testAirportService.getAirportByAirportCode(airportCode);

        assertEquals(resultFromGW[1], resultFromService);
    }

    public void function getAirportByAirportCode()
    {
        searchStruct = { airportCode = airportCode };

        resultFromGW = testAirportGW.filter(searchStruct);
        resultFromService = testAirportService.getAirportByAirportCode(airportCode);

        assertEquals(resultFromGW[1], resultFromService);
    }
}
