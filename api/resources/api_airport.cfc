component extends = "taffy.core.resource" taffy_uri="/api/airports"
{

	//TODO unstub and pull live from database.
	function get()
	{	
		containingStruct = {};
		REGIONS = [];
		REGION_STRUCT = structNew();
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
		arrayAppend(hubData.airports, airportStruct2);

		hubData2 = structNew();
		hubData2.hub_name = "RND";
		hubData2.Airports = [];

		airportStruct3 = structNew();
		airportStruct3.FAA_CODE = "RND";
		airportStruct4 = structNew();
		airportStruct4.FAA_CODE = "FAI";
		arrayAppend(hubData2.airports, airportStruct3);
		arrayAppend(hubData2.airports, airportStruct4);


		arrayAppend(districtStruct.hubs, hubData);
		arrayAppend(districtStruct.hubs, hubData2);
		arrayAppend( districts, districtStruct);
		
		REGION_STRUCT.districts = districts;
		arrayAppend(REGIONS, REGION_STRUCT);
		

		containingStruct = structNew();
		containingStruct.REGIONS = REGIONS;
		

		return representationOf(containingStruct).withStatus(200);
	}
}