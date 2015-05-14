component DistrictDAO extends = "dotlog.model.dataAccess.DAO"
{
	variables.queryHandler = '';

	public districtDAO function init(required dotlog.model.beans.datasource datasource)
	{
		variables.queryHandler = new dotlog.model.queryHandler(arguments.datasource);
		return this;
	}

	public dotlog.model.beans.district function search(required struct searchFilter)
	{
		var queryHandler = new query();

		queryHandler.setName("searchForDistrict");
		
		var sqlString = "SELECT region_name, district_name, enabled "
					& " FROM DL_DISTRICTS " 
					& " WHERE 1 = 1 ";

		if ( !structIsEmpty(searchFilter) ) {
			if ( structKeyExists(arguments.searchFilter, "districtName") ) {
				queryHandler.addParam(name = "districtName", value = arguments.searchFilter.districtName, cfsqltype = "cf_sql_varchar");
				sqlString &= " AND district_name = :districtName ";
			}
			if ( structKeyExists(arguments.searchFilter, "regionName") ) {
				queryHandler.addParam(name = "regionName", value = arguments.searchFilter.regionName, cfsqltype = "cf_sql_varchar");
				sqlString &= " AND region_name = :regionName ";
			}
			if ( structKeyExists(arguments.searchFilter, "districtID") ) {
				queryHandler.addParam(name = "districtID", value = arguments.searchFilter.districtID, cfsqltype = "cf_sql_number");
				sqlString &= " AND district_id = :districtID ";
			}
		}
					
		queryResult = variables.queryHandler.executeQuery(queryHandler, sqlString).getResult();
		
		return new dotlog.model.beans.district(districtName = queryResult["district_name"][1],
											regionName = queryResult["region_name"][1],
											enabled = queryResult["enabled"][1]);
	}

	public boolean function save(required dotlog.model.beans.district district)
	{
		if ( exists(arguments.district) ) {
			return update(arguments.district);
		} else {
			return create(arguments.district);
		}
	}

	private boolean function exists(required dotlog.model.beans.district district)
	{
		var queryHandler = getQueryHandler("doesDistrictExist", arguments.district);
		sqlString = "SELECT district_id "
					& " FROM DL_DISTRICTS "
					& " WHERE district_id = :districtID";
		queryResult = variables.queryHandler.executeQuery(queryHandler, sqlString);
		return queryResult.getResult().recordCount;
	}

	private boolean function create(required dotlog.model.beans.district district)
	{
		var queryHandler = getQueryHandler("createDistrict", arguments.district);
		sqlString = "INSERT INTO DL_DISTRICTS " 
					& "(district_name, region_name, enabled) "
					& "VALUES (:districtName, :regionName, :enabled)";
		queryResult = variables.queryHandler.executeQuery(queryHandler, sqlString);
		return len(queryResult.getPrefix().rowID); //returns a number - need to fix?
	}

	private boolean function update(required dotlog.model.beans.district district)
	{
		var queryHandler = getQueryHandler("updateDistrict", arguments.district);
		sqlString = "UPDATE DL_DISTRICTS SET "
					& "district_name = :districtName, region_name = :regionName, enabled = :enabled "
					& "WHERE district_id = :districtID";
		queryResult = variables.queryHandler.executeQuery(queryHandler, sqlString);
		return len(queryResult.getPrefix().recordCount);
	}

	private base function getQueryHandler(required string queryName, required dotlog.model.beans.district district)
	{
		var queryHandler = new query();

		queryHandler.setName(arguments.queryName);

		if ( arguments.district.getDistrictID() ) {
			queryHandler.addParam(name = "districtID", value = arguments.district.getDistrictID(), cfsqltype = "cf_sql_number");
		}
		queryHandler.addParam(name = "regionName", value = arguments.district.getRegionName(), cfsqltype = "cf_sql_varchar");
		queryHandler.addParam(name = "districtName", value = arguments.district.getDistrictName(), cfsqltype = "cf_sql_varchar");
		queryHandler.addParam(name = "enabled", value = arguments.district.isEnabled(), cfsqltype = "cf_sql_number");

		return queryHandler;
	}
}
