component userTest extends = "mxunit.framework.TestCase" {
	AirportCode = "AUK";
    parentAirportCode = "Northern";
    airportName = "Alakanuk";
    enabled = 1;

	public void function setUp()
	{
		testAirport = new dotlog.model.beans.airport(AirportCode,
                                                 parentAirportCode,
                                                 airportName,
                                                 enabled);
	}

	public void function getAirportCode()
	{
		expected = AirportCode;
		actual = testAirport.getAirportCode();
		assertEquals(expected, actual);
	}

    public void function getParentAirportCode()
    {
        expected = ParentAirportCode;
        actual = testAirport.getParentAirportCode();
        assertEquals(expected, actual);
    }

    public void function getName() 
    {
    	expected = airportName;
    	actual = testAirport.getAirportName();
    	assertEquals(expected, actual);
    }

    public void function isEnabled()
    {
        assert(testAirport.isEnabled());
    }
}