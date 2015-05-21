component DistrictServiceTests extends = "mxunit.framework.TestCase"
{
    DSName = "DOTlogDB";
    DSuser = " ";
    DSpasswd = " ";

    districtName = "test";
    districtID = 93;
    regionID = 120;
    enabled = 1;
    

	public void function setUp()
	{
        datasource = new dotlog.model.beans.datasource(DSName, DSuser, DSpasswd);
        districtDAO = new dotlog.model.dataAccess.districtDAO(datasource);
        districtGW = new dotlog.model.dataAccess.districtGateway(datasource);
        
        testDistrictDAO = new dotlog.tests.server.DAOTestAdapter(districtDAO);
        testDistrictGW = new dotlog.tests.server.gatewayTestAdapter(districtGW);
        testDistrictService = new dotlog.model.service.districtService(testDistrictDAO, testDistrictGW);

		testDistrict = new dotlog.model.beans.district(districtName,
                                                        regionID,
                                                        enabled,
                                                        districtID);
	}

    public void function saveDistrict()
    {
        assertTrue(testDistrictService.saveDistrict(testDistrict) && testDistrictDAO.save(testDistrict));
    }

    public void function getDistrictByName()
    {      
        searchStruct = { districtName = districtName };

        resultFromGW = testDistrictGW.filter(searchStruct);
        resultFromService = testDistrictService.getDistrictByName(districtName);

        assertEquals(resultFromGW[1], resultFromService);
    }

    public void function getEnabledDistricts()
    {
        searchStruct = { enabled = enabled };

        resultFromGW = testDistrictGW.filter(searchStruct);
        resultFromService = testDistrictService.getEnabledDistricts();

        assertEquals(resultFromGW, resultFromService);
    }

    public void function getAllDistricts()
    {
        resultFromGW = testDistrictGW.filter();
        resultFromService = testDistrictService.getAllDistricts();

        assertEquals(resultFromGW, resultFromService);
    }

    public void function getDistrictByID()
    {
        searchStruct = { districtID = districtID };

        resultFromGW = testDistrictGW.filter(searchStruct);
        resultFromService = testDistrictService.getDistrictByID(districtID);

        assertEquals(resultFromGW[1], resultFromService);        
    }
}
