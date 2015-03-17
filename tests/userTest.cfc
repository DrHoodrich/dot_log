<cfscript>
component dataBaseTest extends = "mxunit.framework.TestCase" {
/*
	public void function setUp(){
		queryService = new query();

		queryService.setName("GetUserID");
		queryService.setDataSource("DOTlogDB");
		queryService.addParam(name = "user", value = "12", cfsqltype = "cf_sql_number"); // <!--- seems this is tight coupling --->

		queryResult = queryService.execute(sql = "SELECT * FROM DAL_USERS WHERE USER_ID = :user");
		
		WriteDump(queryResult);
		WriteDump(queryResult.getResult());

		x = queryResult.getResult();
	//	WriteDump(x["RESULTSET"]);

		//for (ii = 1; ii <= queryResult.recordcount; ii++) {
			writeOutput(queryResult.getResult().AIRPORT_ID[1]);
		//}
	}
*/

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

	public void function get_user_initials()
	{
		testUser = createObject("component", "user");
		expected = "B. D.";
		actual = testUser.getInitials();
		assertEquals(expected, actual);		
	}
}
</cfscript>