component RegionDAOTests extends = "mxunit.framework.TestCase"
{
	DSName = "DOTlogDB";
	DSuser = " ";
	DSpasswd = " ";

	regionName = "testRegion";
	regionID = 30;

	public void function setUp()
	{
		datasource = new dotlog.model.beans.datasource(DSName, DSuser, DSpasswd);
		regionDAO = new dotlog.model.dataAccess.regionDAO(datasource);
		testRegionDAO = new dotlog.tests.server.DAOTestAdapter(regionDAO);
		testRegion = new dotlog.model.beans.region(regionName);
	}

	public void function regionDAOConstruction()
	{		
		assertSame(regionDAO, regionDAO.init(datasource));
	}

	public void function regionDAOCreateRegion()
	{
		assertTrue(testRegionDAO.save(testRegion));
	}

	public void function updateRegion()
	{
		testRegion = new dotlog.model.beans.region(regionName, regionID);
		assertTrue(testRegionDAO.save(testRegion));
	}
}