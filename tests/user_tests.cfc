<cfscript>
component dataBaseTest extends = "mxunit.framework.TestCase" {

	public void function user_obj_creation()
	{
		test = createObject("component", "user").init("Bob Dylan");

		expected = "Bob Dylan";
		actual = test.getName();
		assertEquals(expected, actual);

	}

	public void function get_user_name()
	{
		testUser = createObject("component", "user").init("Bob Dylan");
		expected = "bob dylan"; // Note, that that the strings are insensitive.
		actual = testUser.getName();
		assertEquals(expected, actual);	
	}

	public void function get_user_airport_hubs()
	{
		user = createObject("component", "User").init("admin");
		expected = [25, 26];
		actual = user.getAirportID();
		assertEquals(expected, actual);
	}
}
</cfscript>