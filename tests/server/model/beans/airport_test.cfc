component AirportTest extends = "mxunit.framework.TestCase"
{
	AirportCode = "AUK";
	hubCode = "Northern";
	airportName = "Alakanuk";
	districtID = 3;
	enabled = 1;

	public void function setUp()
	{
		testAirport = new dotlog.model.beans.airport(AirportCode,
													hubCode,
													airportName,
													districtID,
													enabled);
	}

	public void function getAirportCode()
	{
		expected = AirportCode;
		actual = testAirport.getAirportCode();
		assertEquals(expected, actual);
	}

    public void function getHubCode()
    {
        expected = hubCode;
        actual = testAirport.getHubCode();
        assertEquals(expected, actual);
    }

	public void function getName() 
	{
		expected = airportName;
		actual = testAirport.getAirportName();
		assertEquals(expected, actual);
	}

	public void function getDistrictID() 
	{
		expected = districtID;
		actual = testAirport.getDistrictID();
		assertEquals(expected, actual);
	}

	public void function isEnabled()
	{
		assert(testAirport.isEnabled());
	}
}