component UserDAOTests extends = "mxunit.framework.TestCase"
{
	DSName = "DOTlogDB";
	DSuser = " ";
	DSpasswd = " ";

	username = "tester";
	firstName = "Bob";
	lastName = "Dylan";
	airportCode = "AUK";
	permissions = "1";
	enabled = "1";
	districtManager = "1";
	regionManager = "1";
	emailAddr = "test";
	
	public void function setUp()
	{
		datasource = new dotlog.model.beans.datasource(DSName, DSuser, DSpasswd);
		userDAO = new dotlog.model.dataAccess.userDAO(datasource);
		testUserDAO = new dotlog.tests.server.DAOTestAdapter(userDAO);
		testUser = new dotlog.model.beans.user(username,
												firstName,
												lastName,
												airportCode,
												permissions,
												enabled,
												districtManager,
												regionManager,
												emailAddr);
	}

	public void function userDAOConstruction()
	{		
		assertSame(userDAO, userDAO.init(datasource));
	}

	public void function userDAOCreateUser()
	{
		assertTrue(testUserDAO.save(testUser));
	}

	public void function updateUser()
	{
		lastNameChanged = "DylanBob";
		testUser = new dotlog.model.beans.user(username,
											firstName,
											lastNameChanged,
											airportCode,
											permissions,
											enabled,
											districtManager,
											regionManager,
											emailAddr);

		assertTrue(testUserDAO.save(testUser));
	}
}