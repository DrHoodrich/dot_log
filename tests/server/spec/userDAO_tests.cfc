component UserDAOTests extends = "mxunit.framework.TestCase"
{
	DSName = "DOTlogDB";
	DSuser = " ";
	DSpasswd = " ";

	username = "tester";
    firstName = "Bob";
    lastName = "Dylan";
    faaCode = "AUK";
    permissions = "1";
    enabled = "1";
    emailAddr = "test";
	public void function setUp()
	{
		datasource = new dotlog.components.datasource(DSName, DSuser, DSpasswd);
		testUser = new dotlog.components.user(username,
                                              firstName,
                                              lastName,
                                              faaCode,
                                              permissions,
                                              enabled,
                                              emailAddr);
	}

	public void function userDAOConstruction()
	{
		userDAO = new dotlog.components.userDAO(datasource);
		assertSame(userDAO, userDAO.init(datasource));
	}

	public void function userDAOCreateUesr()
	{
		userDAO = new dotlog.components.userDAO(datasource);
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

	public void function userExists()
	{
		username = "us";
	    firstName = "Bob";
	    lastName = "Dylan";
	    faaCode = "AUK";
	    permissions = "1";
	    enabled = "1";
	    testUser = new dotlog.components.user(username,
	                                              firstName,
	                                              lastName,
	                                              faaCode,
	                                              permissions,
	                                              enabled,
	                                              emailAddr);
	    userDAO = new dotlog.components.userDAO(datasource);
	    assert(userDAO.userExists(testUser));
	}

	public void function tryCreateExistingUser()
	{
		username = "us";
	    firstName = "Bob";
	    lastName = "Dylan";
	    faaCode = "AUK";
	    permissions = "1";
	    enabled = "1";
	    emailAddr = "test";
	    testUser = new dotlog.components.user(username,
	                                              firstName,
	                                              lastName,
	                                              faaCode,
	                                              permissions,
	                                              enabled,
	                                              emailAddr);
	    userDAO = new dotlog.components.userDAO(datasource);
	    assertFalse(userDAO.createUser(testUser));
	}
}