component DistrictGateway extends = "dotlog.model.dataAccess.gateway"
{
	variables.queryHandler = '';
	
	public districtGateway function init(required dotlog.model.beans.datasource datasource)
	{
		variables.queryHandler = new dotlog.model.queryHandler(arguments.datasource);
		return this;
	}

	public array function filter(struct searchFilter=structNew())
	{
		var queryService = new query();
		var sqlString = " SELECT district_name, region_name, enabled "
						& " FROM DL_DISTRICTS "
						& " WHERE 1 = 1 ";

		if ( structKeyExists(searchFilter, "districtName") ) {
			queryService.setName("fetchDistrict");
			queryService.addParam(name = "districtName", value = arguments.searchFilter.parentAirportCode, cfsqltype = "cf_sql_varchar");
			sqlString &= " AND district_name = :districtName";
		}
		if ( structKeyExists(searchFilter, "regionName") ) {
			queryService.setName("fetchRegion");
			queryService.addParam(name = "regionName", value = arguments.searchFilter.regionName, cfsqltype = "cf_sql_varchar");
			sqlString &= " AND region_name = :regionName";
		}
		var queryResult = queryHandler.executeQuery(queryService, sqlString);
		var result = queryResult.getResult();
		var districts = [];
		for (var ii = 1; ii <= result.RecordCount; ++ii) {
			 district = new dotlog.model.beans.district(regionName = result["region_name"][ii],
														districtName = result["district_name"][ii],
														enabled = result["enabled"][ii]);
							
			 arrayAppend(districts, district);
		}
		return districts;
	}
}