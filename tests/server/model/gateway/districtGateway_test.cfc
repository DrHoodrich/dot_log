component DistrictGatewayTest extends = "mxunit.framework.TestCase"
{
    DSName = "DOTlogDB";
    DSuser = " ";
    DSpasswd = " ";

    districtName = "test";    
    isEnabled = 1;
    districtID = 93;
    regionID = 120;
        
	public void function setUp()
	{
        datasource = new dotlog.model.beans.datasource(DSName, DSuser, DSpasswd);     
        districtGW = new dotlog.model.dataAccess.districtGateway(datasource);
        testDistrictGW = new dotlog.tests.server.gatewayTestAdapter(districtGW);
	}

    public void function districtByID()
    {
        expected = 1;
        searchStruct = { districtID = districtID };
        actual = arrayLen(testDistrictGW.filter(searchStruct));
        assertEquals(expected, actual);
    }

    public void function districtByRegion()
    {
        searchStruct = { regionID = regionID };
        districts = testDistrictGW.filter(searchStruct);
        assertTrue(arrayLen(districts));
    }

    public void function enabledDistricts()
    {
        searchStruct = { enabled = 1 };
        districts = testDistrictGW.filter(searchStruct);
        var allEnabled = 1;
        for (var ii = 1; ii <= arrayLen(districts); ++ii) {
            if (!districts[ii].isEnabled()) {
                allEnabled = 0;
            }
        }
        assertTrue(allEnabled);
    }
}