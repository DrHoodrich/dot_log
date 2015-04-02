component userTest extends = "mxunit.framework.TestCase" {
	FAACode = "AUK";
    parentFAACode = "Northern";
    airportName = "Alakanuk";
    enabled = 1;

	public void function setUp()
	{
		testAirport = new dotlog.components.airport(FAACode,
                                                 parentFAACode,
                                                 airportName,
                                                 enabled);
	}

	public void function getFAACode()
	{
		expected = FAACode;
		actual = testAirport.getFAACode();
		assertEquals(expected, actual);
	}

    public void function getParentAirportFAACode()
    {
        expected = ParentFAACode;
        actual = testAirport.getParentAirportFAACode();
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