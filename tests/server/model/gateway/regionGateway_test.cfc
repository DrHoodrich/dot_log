component RegionGatewayTest extends = "mxunit.framework.TestCase"
{
    DSName = "DOTlogDB";
    DSuser = " ";
    DSpasswd = " ";

	regionName = "test";
    regionID = 120;
    
	public void function setUp()
	{
        datasource = new dotlog.model.beans.datasource(DSName, DSuser, DSpasswd);     
        regionGW = new dotlog.model.dataAccess.regionGateway(datasource);
        testRegionGW = new dotlog.tests.server.gatewayTestAdapter(regionGW);
	}

    public void function regionByRegionID()
    {
        expected = 1;
        searchStruct = { regionID = regionID };
        actual = arrayLen(testRegionGW.filter(searchStruct));
        assertEquals(expected, actual);
    }

    public void function regionByRegionName()
    {
        expected = 1;
        searchStruct = { regionName = regionName };
        actual = arrayLen(testRegionGW.filter(searchStruct));
        assertEquals(expected, actual);
    }

    public void function allRegions()
    {
        searchStruct = {};
        regions = testRegionGW.filter(searchStruct);
        assertTrue(arrayLen(regions));
    }
}
