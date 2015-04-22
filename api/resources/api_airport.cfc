component extends = "taffy.core.resource" taffy_uri="/api/airports"

{

	function get()
	{	
		airports = [];
		airportChildren = [];
		airport = session.user.getAirportCode();

		airportStruct = structNew();
		airportStruct.faa_code = session.user.getAirportCode();
		arrayAppend(airports, airportStruct);
		
		airportChildren = application.airportService.getChildAirports(airport);

		for (i = 1 ; i <= ArrayLen(airportChildren); i++)
		{
			airportStruct = structNew();
			airportStruct.faa_code = airportChildren[i].getAirportCode();
			arrayAppend(airports,airportStruct);
		}
		
		containingStr = structNew();
		containingStr.airports = airports;

		return representationOf(containingStr).withStatus(200);
	}
}