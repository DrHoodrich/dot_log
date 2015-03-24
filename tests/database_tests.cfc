<cfscript>
component dataBaseTest extends = "mxunit.framework.TestCase" {
	public void function setUp() {
		/*
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
		*/
		queryService = new query();

		queryService.setName("getAirport");
		queryService.setDataSource("DOTlogDB");
		queryService.addParam(name = "hub_airport_ID", value = "21", cfsqltype = "cf_sql_number");

		queryResult = queryService.execute(sql = "SELECT * FROM DAL_AIRPORTS WHERE AIRPORT_ID = :hub_airport_ID OR PID = :hub_airport_ID");
		
		WriteDump(queryResult);
		WriteDump(queryResult.getResult());
	}


	public void function get_hub_airport_test()  {
		queryService = new query();

		queryService.setName("getAirport");
		queryService.setDataSource("DOTlogDB");
		queryService.addParam(name = "hub_airport_ID", value = "21", cfsqltype = "cf_sql_number");

		queryResult = queryService.execute(sql = "SELECT * FROM DAL_AIRPORTS");
		
		results = queryResult.getResult();

		assertEquals(results.recordcount, 2);
	}
/*	public void function getUserIDTest(){
		RomanNumeral = createObject("component", "database");
		expected = "I";
		actual = RomanNumeral.decode(1);
		assertEquals(expected, actual);	

	}
*/
}
</cfscript>