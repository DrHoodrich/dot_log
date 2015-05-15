component AirportTest extends = "mxunit.framework.TestCase"
{
	AirportCode = "AUK";
	hubCode = "Northern";
	airportName = "Alakanuk";
	districtName = "Tok";
	enabled = 1;

	public void function setUp()
	{
		testAirport = new dotlog.model.beans.airport(AirportCode,
													hubCode,
													airportName,
													districtName,
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

	public void function getDistrict() 
	{
		expected = districtName;
		actual = testAirport.getDistrictName();
		assertEquals(expected, actual);
	}

	public void function isEnabled()
	{
		assert(testAirport.isEnabled());
	}
}