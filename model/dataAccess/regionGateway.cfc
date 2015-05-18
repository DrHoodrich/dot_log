component regionGateway extends = "dotlog.model.dataAccess.gateway"
{
	variables.queryHandler = '';
	
	public regionGateway function init(required dotlog.model.beans.datasource datasource)
	{
		variables.queryHandler = new dotlog.model.queryHandler(arguments.datasource);
		return this;
	}

	public array function filter(struct searchFilter=structNew())
	{
		var queryService = new query();
		var sqlString = " SELECT region_id, region_name "
						& " FROM DL_REGIONS "
						& " WHERE 1 = 1 ";

		if ( !structIsEmpty(searchFilter) ) {
			queryService.setName("filterRegions");
			if ( structKeyExists(searchFilter, "regionID") ) {
				queryService.addParam(name = "regionID", value = arguments.searchFilter.regionID, cfsqltype = "cf_sql_number");
				sqlString &= " AND region_id = :regionID";
			}
			if ( structKeyExists(searchFilter, "regionName") ) {
				queryService.addParam(name = "regionName", value = arguments.searchFilter.regionName, cfsqltype = "cf_sql_varchar");
				sqlString &= " AND region_name = :regionName";
			}
		} else {
			queryService.setName("getAllRegions");
		}
		var queryResult = queryHandler.executeQuery(queryService, sqlString);
		var result = queryResult.getResult();
		var regions = [];
		for (var ii = 1; ii <= result.RecordCount; ++ii) {
			 region = new dotlog.model.beans.region(regionID = result["region_id"][ii],
													regionName = result["region_name"][ii]);
							
			 arrayAppend(regions, region);
		}
		return regions;
	}
}