component AirportDAOTests extends = "mxunit.framework.TestCase"
{
	DSName = "DOTlogDB";
	DSuser = " ";
	DSpasswd = " ";

	AirportCode = "AUK";
    parentAirportCode = "Northern";
    airportName = "Alakanuk";
    enabled = 1;

	public void function setUp()
	{
		datasource = new dotlog.model.beans.datasource(DSName, DSuser, DSpasswd);
		airportDAO = new dotlog.model.dataAccess.airportDAO(datasource);
		testAirportDAO = new dotlog.tests.server.DAOTestAdapter(airportDAO);
		testAirport = new dotlog.model.beans.airport(AirportCode,
                                                 parentAirportCode,
                                                 airportName,
                                                 enabled);
	}

	public void function airportDAOConstruction()
	{		
		assertSame(airportDAO, airportDAO.init(datasource));
	}

	public void function airportDAOCreateAirport()
	{
		assertTrue(testAirportDAO.save(testAirport));
	}

	public void function updateAirport()
	{
	    testAirport = new dotlog.model.beans.airport(AirportCode,
                                                 parentAirportCode,
                                                 airportName,
                                                 enabled);
	    assertTrue(testAirportDAO.save(testAirport));
	}
}