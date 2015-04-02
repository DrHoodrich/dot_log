component DatasourceTests extends = "mxunit.framework.TestCase"
{
	public void function setUp()
	{
        DSName = "testDSname";
        DSuser = "testDSusername";
        DSpasswd = "testDSpassword";
		datasource = new dotlog.components.datasource(DSName, DSuser, DSpasswd);
	}

	public void function getDSName()
	{
		expected = DSname;
		actual = datasource.getDSName();
		assertEquals(expected, actual);
	}

    public void function getDSusername() 
    {
    	expected = DSuser;
    	actual = datasource.getUsername();
    	assertEquals(expected, actual);
    }

    public void function getDSpassword()
    {
		expected = DSpasswd;
		actual = datasource.getPassword();
		assertEquals(expected, actual);
    }
}