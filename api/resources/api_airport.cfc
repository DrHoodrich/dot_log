component extends = "taffy.core.resource" taffy_uri="/api/airports"
{
	DSName = "DOTlogDB";
	DSuser = " ";
	DSpasswd = " ";
	datasource = new dotlog.components.datasource(DSName, DSuser, DSpasswd);

	airportDAO = new dotlog.components.airportDAO(datasource);

	 user = application.userService.getUserByUsername("us");

	function get()
	{	
		airportStr = structNew();
		airportStr.faa_code = "FAI";

		airportStr2 = structNew();
		airportStr2.faa_code = "Northern";


		testArray = [];
		arrayAppend(testArray, airportStr);
		arrayAppend(testArray, airportStr2);
		
		containingStr = structNew();
		containingStr.airports = testArray;

		return representationOf(containingStr).withStatus(200);
	}
}