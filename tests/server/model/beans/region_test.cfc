component RegionTest extends = "mxunit.framework.TestCase"
{
	regionID = 1;
	regionName = "testRegion";
	
	public void function setUp()
	{
		testRegion = new dotlog.model.beans.region(regionName, regionID);
	}

	public void function getRegionID()
	{
		expected = regionID;
		actual = testRegion.getRegionID();
		assertEquals(expected, actual);
	}

    public void function getRegionName()
    {
        expected = regionName;
        actual = testRegion.getRegionName();
        assertEquals(expected, actual);
    }
}