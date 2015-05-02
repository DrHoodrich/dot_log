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
    emailAddr = "test";
	public void function setUp()
	{
		datasource = new dotlog.model.beans.datasource(DSName, DSuser, DSpasswd);
		testUser = new dotlog.model.beans.user(username,
                                              firstName,
                                              lastName,
                                              airportCode,
                                              permissions,
                                              enabled,
                                              emailAddr);
	}

	public void function userDAOConstruction()
	{
		userDAO = new dotlog.model.dataAccess.userDAO(datasource);
		assertSame(userDAO, userDAO.init(datasource));
	}

	public void function userDAOCreateUesr()
	{
		fail("Need to implement.");
		userDAO = new dotlog.model.dataAccess.userDAO(datasource);
		transaction action="begin"
		{
			userDAO.getUserByUsername("us");
	        
	        transactionSetSavepoint( "SP1" );
			userDAO.init(datasource);
			if (false) {
	            transactionRollback();
	        }			
			userDAO.createUser(testUser);			
	        
	        transactionRollback();
	    }
	}

	public void function tryCreateExistingUser()
	{
		fail("Need to implement.");
		username = "Administrator";
	    firstName = "Bob";
	    lastName = "Dylan";
	    airportCode = "AUK";
	    permissions = "1";
	    enabled = "1";
	    emailAddr = "test";
	    testUser = new dotlog.model.beans.user(username,
	                                              firstName,
	                                              lastName,
	                                              airportCode,
	                                              permissions,
	                                              enabled,
	                                              emailAddr);

	    userDAO = new dotlog.model.dataAccess.userDAOTestAdapter(datasource);
	    userDAO.createNewUser(testUser);
	}
}