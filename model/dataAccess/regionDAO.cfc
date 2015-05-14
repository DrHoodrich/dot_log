component RegionDAO extends = "dotlog.model.dataAccess.DAO"
{
	variables.queryHandler = '';

	public regionDAO function init(required dotlog.model.beans.datasource datasource)
	{
		variables.queryHandler = new dotlog.model.queryHandler(arguments.datasource);
		return this;
	}

	public dotlog.model.beans.region function search(required struct searchFilter)
	{
		var queryHandler = new query();

		queryHandler.setName("searchForRegion");
		
		var sqlString = "SELECT region_name, region_name "
					& " FROM DL_REGIONS " 
					& " WHERE 1 = 1 ";

		if ( !structIsEmpty(searchFilter) ) {
			if ( structKeyExists(arguments.searchFilter, "regionName") ) {
				queryHandler.addParam(name = "regionName", value = arguments.searchFilter.regionName, cfsqltype = "cf_sql_varchar");
				sqlString &= " AND region_name = :regionName ";
			}
			if ( structKeyExists(arguments.searchFilter, "regionID") ) {
				queryHandler.addParam(name = "regionID", value = arguments.searchFilter.regionID, cfsqltype = "cf_sql_number");
				sqlString &= " AND region_id = :regionID ";
			}
		}
					
		queryResult = variables.queryHandler.executeQuery(queryHandler, sqlString).getResult();
		
		return new dotlog.model.beans.region(regionID = queryResult["region_id"][1],
											regionName = queryResult["region_name"][1]);
	}

	public boolean function save(required dotlog.model.beans.region region)
	{
		if ( exists(arguments.region) ) {
			return update(arguments.region);
		} else {
			return create(arguments.region);
		}
	}

	private boolean function exists(required dotlog.model.beans.region region)
	{
		var queryHandler = getQueryHandler("doesRegionExist", arguments.region);
		sqlString = "SELECT region_ID"
					& " FROM DL_REGIONS "
					& " WHERE region_id = :regionID";
		queryResult = variables.queryHandler.executeQuery(queryHandler, sqlString);
		return queryResult.getResult().recordCount;
	}

	private boolean function create(required dotlog.model.beans.region region)
	{
		var queryHandler = getQueryHandler("createRegion", arguments.region);
		sqlString = "INSERT INTO DL_REGIONS " 
					& "(region_name) "
					& "VALUES (:regionName)";
		queryResult = variables.queryHandler.executeQuery(queryHandler, sqlString);
		return len(queryResult.getPrefix().rowID); //returns a number - need to fix?
	}

	private boolean function update(required dotlog.model.beans.region region)
	{
		var queryHandler = getQueryHandler("updateRegion", arguments.region);
		sqlString = "UPDATE DL_REGIONS SET "
					& " region_name = :region_name "
					& "WHERE region_id = :regionID";
		queryResult = variables.queryHandler.executeQuery(queryHandler, sqlString);
		return len(queryResult.getPrefix().recordCount);
	}

	private base function getQueryHandler(required string queryName, required dotlog.model.beans.region region)
	{
		var queryHandler = new query();

		queryHandler.setName(arguments.queryName);
		if ( arguments.region.getRegionID() ) {
			queryHandler.addParam(name = "regionID", value = arguments.region.getRegionID(), cfsqltype = "cf_sql_number");
		}
		queryHandler.addParam(name = "regionName", value = arguments.region.getRegionName(), cfsqltype = "cf_sql_varchar");

		return queryHandler;
	}
}
