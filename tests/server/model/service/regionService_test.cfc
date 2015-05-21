component regionServiceTests extends = "mxunit.framework.TestCase"
{
    DSName = "DOTlogDB";
    DSuser = " ";
    DSpasswd = " ";

    regionID = "test";
    regionName = "test";
    regionID = 120;
    
	public void function setUp()
	{
        datasource = new dotlog.model.beans.datasource(DSName, DSuser, DSpasswd);
        regionDAO = new dotlog.model.dataAccess.regionDAO(datasource);
        regionGW = new dotlog.model.dataAccess.regionGateway(datasource);
        
        testRegionDAO = new dotlog.tests.server.DAOTestAdapter(regionDAO);
        testRegionGW = new dotlog.tests.server.gatewayTestAdapter(regionGW);
        testRegionService = new dotlog.model.service.regionService(testRegionDAO, testRegionGW);

		testRegion = new dotlog.model.beans.region(regionName, regionID);
	}

    public void function saveRegion()
    {
        assertTrue(testRegionService.saveRegion(testRegion) && testRegionDAO.save(testRegion));
    }

    public void function getRegionByID()
    {
        searchStruct = { regionID = regionID };

        resultFromGW = testRegionGW.filter(searchStruct);
        resultFromService = testRegionService.getRegionByID(regionID);

        assertEquals(resultFromGW[1], resultFromService);
    }

    public void function getRegionByName()
    {
        searchStruct = { regionName = regionName };

        resultFromGW = testRegionGW.filter(searchStruct);
        resultFromService = testRegionService.getRegionByName(regionName);

        assertEquals(resultFromGW[1], resultFromService);
    }

    public void function getAllRegions()
    {
        resultFromGW = testRegionGW.filter();
        resultFromService = testRegionService.getAllRegions();

        assertEquals(resultFromGW, resultFromService);
    }
}
