component DistrictGatewayTest extends = "mxunit.framework.TestCase"
{
    DSName = "DOTlogDB";
    DSuser = " ";
    DSpasswd = " ";

    categoryTitle = "test";
    description = "test";
    airportName = "test";    
    isEnabled = 1;
    districtID = 428;
        
	public void function setUp()
	{
        datasource = new dotlog.model.beans.datasource(DSName, DSuser, DSpasswd);     
        districtGW = new dotlog.model.dataAccess.categoryGateway(datasource);
        testDistrictGW = new dotlog.tests.server.gatewayTestAdapter(districtGW);
	}

    public void function categoryByID()
    {
        expected = 1;
        searchStruct = { districtID = districtID };
        actual = arrayLen(testDistrictGW.filter(searchStruct));
        assertEquals(expected, actual);
    }

    public void function categoriesByDescription()
    {
        searchStruct = { description = description };
        categories = testDistrictGW.filter(searchStruct);
        assertTrue(arrayLen(categories));
    }

    public void function enabledCategories()
    {
        searchStruct = { enabled = isEnabled };
        categories = testDistrictGW.filter(searchStruct);
        assertTrue(arrayLen(categories));
    }

    public void function allCategories()
    {
        searchStruct = {};
        categories = testDistrictGW.filter(searchStruct);
        assertTrue(arrayLen(categories));
    }
}