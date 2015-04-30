component extends = "taffy.core.resource" taffy_uri="/api/airports"
{

	//TODO unstub and pull live from database.
	function get()
	{	
		containingStruct = {};
		REGIONS = [];
		REGION_STRUCT = {};
		REGION_STRUCT.REGION_NAME = "Northern";
		
		districts = [];
		districtStruct = structNew();
		districtStruct.district_name = "Western";
		districtStruct.hubs = [];


		hubData = structNew();
		hubData.hub_name = "OTZ";
		hubData.Airports = [];

		airportStruct1 = structNew();
		airportStruct1.FAA_CODE = "OTZ";
		airportStruct2 = structNew();
		airportStruct2.FAA_CODE = "AFM";
		arrayAppend(hubData.airports, airportStruct1);
		arrayAppend(hubData.airports, airportStruct1);


		arrayAppend(districtStruct.hubs, hubData);
		arrayAppend( districts, districtStruct);
		
		REGION_STRUCT.districts = districts;
		arrayAppend(REGIONS, REGION_STRUCT);
		

		containingStruct = structNew();
		containingStruct.REGIONS = REGION_STRUCT;
		

		return representationOf(containingStruct).withStatus(200);
	}
}