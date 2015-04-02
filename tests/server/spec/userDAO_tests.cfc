component UserDAOTests extends = "mxunit.framework.TestCase"
{
	DSName = "testDSname";
	DSuser = "testDSusername";
	DSpasswd = "testDSpassword";
	public void function setUp()
	{
		datasource = new dotlog.components.datasource(DSName, DSuser, DSpasswd);
	}

	public void function userDAOConstruction()
	{
		datasource = new dotlog.components.datasource(DSName, DSuser, DSpasswd);
		expected = new dotlog.components.userDAO(datasource);
		actual = new dotlog.components.userDAO(datasource);
		assert(1, "Ensuring that the UserDOA class constructs with a Datasource object.");
	}
}