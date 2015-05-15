component DistrictDAOTests extends = "mxunit.framework.TestCase"
{
	DSName = "DOTlogDB";
	DSuser = " ";
	DSpasswd = " ";

	
	districtID = 1;
	districtName = "testDistrict1";
	enabled = 1;
	regionName = "testRegion";

	public void function setUp()
	{
		datasource = new dotlog.model.beans.datasource(DSName, DSuser, DSpasswd);
		districtDAO = new dotlog.model.dataAccess.districtDAO(datasource);
		testDistrictDAO = new dotlog.tests.server.DAOTestAdapter(districtDAO);
		testDistrict = new dotlog.model.beans.district(districtName,
													regionName,
													enabled);
	}

	public void function districtDAOConstruction()
	{		
		assertSame(districtDAO, districtDAO.init(datasource));
	}

	public void function districtDAOCreateDistrict()
	{
		assertTrue(testDistrictDAO.save(testDistrict));
	}

	public void function updateDistrict()
	{
		testDistrict = new dotlog.model.beans.district(districtName,
													regionName,
													enabled,
													districtID);
		assertTrue(testDistrictDAO.save(testDistrict));
	}
}