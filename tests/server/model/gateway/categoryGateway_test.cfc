component CategoryGatewayTest extends = "mxunit.framework.TestCase"
{
    DSName = "DOTlogDB";
    DSuser = " ";
    DSpasswd = " ";

    categoryTitle = "test";
    description = "test";
    airportName = "test";    
    isEnabled = 1;
    categoryID = 428;
        
	public void function setUp()
	{
        datasource = new dotlog.model.beans.datasource(DSName, DSuser, DSpasswd);     
        categoryGW = new dotlog.model.dataAccess.categoryGateway(datasource);
        testCategoryGW = new dotlog.tests.server.gatewayTestAdapter(categoryGW);
	}

    public void function categoryByID()
    {
        expected = 1;
        searchStruct = { categoryID = categoryID };
        actual = arrayLen(testCategoryGW.filter(searchStruct));
        assertEquals(expected, actual);
    }

    public void function categoriesByDescription()
    {
        searchStruct = { description = description };
        categories = testCategoryGW.filter(searchStruct);
        assertTrue(arrayLen(categories));
    }

    public void function enabledCategories()
    {
        searchStruct = { enabled = isEnabled };
        categories = testCategoryGW.filter(searchStruct);
        assertTrue(arrayLen(categories));
    }

    public void function allCategories()
    {
        searchStruct = {};
        categories = testCategoryGW.filter(searchStruct);
        assertTrue(arrayLen(categories));
    }
}
