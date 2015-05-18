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
		var sqlString = "SELECT district_id, district_name, region_id, enabled "
						& " FROM DL_DISTRICTS "
						& " WHERE 1 = 1 ";

		if ( !structIsEmpty(searchFilter) ) {
			queryService.setName("filterDistricts");
			if ( structKeyExists(arguments.searchFilter, "districtID") ) {
				queryService.addParam(name = "districtID", value = arguments.searchFilter.districtID, cfsqltype = "cf_sql_number");
				sqlString &= " AND district_id = :districtID ";
			}
			if ( structKeyExists(searchFilter, "districtName") ) {
				queryService.addParam(name = "districtName", value = arguments.searchFilter.districtName, cfsqltype = "cf_sql_varchar");
				sqlString &= " AND district_name = :districtName";
			}
			if ( structKeyExists(searchFilter, "regionID") ) {
				queryService.addParam(name = "regionID", value = arguments.searchFilter.regionID, cfsqltype = "cf_sql_varchar");
				sqlString &= " AND region_id = :regionID";
			}
			if ( structKeyExists(searchFilter, "enabled") ) {
				queryService.addParam(name = "enabled", value = arguments.searchFilter.enabled, cfsqltype = "cf_sql_number");
				sqlString &= " AND enabled = :enabled";
			}
		} else {
			queryService.setName("getAllDistricts");		
		}
		var queryResult = queryHandler.executeQuery(queryService, sqlString);
		var result = queryResult.getResult();
		var districts = [];
		for (var ii = 1; ii <= result.RecordCount; ++ii) {
			 district = new dotlog.model.beans.district(districtID = result["district_id"][ii],
			 											regionID = result["region_id"][ii],
														districtName = result["district_name"][ii],
														enabled = result["enabled"][ii]);
							
			 arrayAppend(districts, district);
		}
		return districts;
	}
}