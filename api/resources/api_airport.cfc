component extends = "taffy.core.resource" taffy_uri="/api/airports"
{
	private any function getDistricts()
	{
		var airport = application.airportService.getAirportByAirportCode(session.user.getAirportCode());
		var district = application.districtService.getDistrictByID(airport.getDistrictID());
		return district;
	}

	private array function getHubs(required numeric districtID)
	{
		var hubs = application.airportService.getHubAirportsByDistrictID(arguments.districtID);
		return hubs;
	}

	private array function getSpokes(required string hubCode)
	{
		var spokes = application.airportService.getSpokeAirports(arguments.hubCode);
		return spokes;
	}

	private dotlog.model.beans.region function getRegion(required numeric regionID)
	{
		var region = application.regionService.getRegionByID(arguments.regionID);
		return region;
	}
	
	function get()
	{
		/*
		if ( session.user.isRegionManager() ) {
			districts = getDistricts();
		} else if ( session.user.isDistrictManager() ) {
			districts = getDistricts();
		} else {
			airports = getAirports();
		}*/

		district = getDistricts();
		region = getRegion(district.getRegionID());
		hubs = getHubs(district.getDistrictID());
		spokes = getSpokes(hubs[1].getAirportCode());

		containingStruct = {};
		REGIONS = [];
		REGION_STRUCT = structNew();
		REGION_STRUCT.REGION_NAME = region.getRegionName();
		
		districts = [];
		districtStruct = structNew();
		districtStruct.district_name = district.getDistrictName();
		districtStruct.hubs = [];

		for (var ii = 1; ii <= arrayLen(hubs); ++ii) {
			hubData = structNew();
			hubData.hub_name = hubs[ii].getAirportName();
			hubData.Airports = [];
			for (var jj = 1; jj <= arrayLen(spokes); ++jj) {
				airportStruct1 = structNew();
				airportStruct1.FAA_CODE = spokes[jj].getAirportName();
				arrayAppend(hubData.airports, airportStruct1);
			}
			arrayAppend(districtStruct.hubs, hubData);
		}
	
		arrayAppend(districts, districtStruct);
		
		REGION_STRUCT.districts = districts;
		arrayAppend(REGIONS, REGION_STRUCT);
		

		containingStruct = structNew();
		containingStruct.REGIONS = REGIONS;
		

		return representationOf(containingStruct).withStatus(200);
	}
}