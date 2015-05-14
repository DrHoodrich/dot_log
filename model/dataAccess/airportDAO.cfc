component AirportDAO extends = "dotlog.model.dataAccess.DAO"
{
	variables.queryHandler = '';

	public airportDAO function init(required dotlog.model.beans.datasource datasource)
	{
		variables.queryHandler = new dotlog.model.queryHandler(arguments.datasource);
		return this;
	}

	public dotlog.model.beans.airport function search(required struct searchFilter)
	{
		var queryHandler = new query();

		queryHandler.setName("searchForAirport");
		
		var sqlString = "SELECT faa_code, hub_code, airport_name, district_name, enabled "
					& "FROM DL_AIRPORTS " 
					& "WHERE 1 = 1 ";

		if ( !structIsEmpty(searchFilter) ) {
			if ( structKeyExists(arguments.searchFilter, "airportCode") ) {
				queryHandler.addParam(name = "faa_code", value = arguments.searchFilter.airportCode, cfsqltype = "cf_sql_varchar");
				sqlString &= " AND faa_code = :faa_code";
			}
		}
					
		queryResult = variables.queryHandler.executeQuery(queryHandler, sqlString).getResult();
		
		return new dotlog.model.beans.airport(airportCode = queryResult["faa_code"][1],
											parentAirportCode = queryResult["hub_code"][1],
											airportName = queryResult["airport_name"][1],
											districtName = queryResult["district_name"][1],
											enabled = queryResult["enabled"][1]);
	}

	public boolean function save(required dotlog.model.beans.airport airport)
	{
		if ( airportExists(arguments.airport) ) {
			return updateAirport(arguments.airport);
		} else {
			return createAirport(arguments.airport);
		}
	}

	private boolean function airportExists(required dotlog.model.beans.airport airport)
	{
		var queryHandler = getQueryHandler("doesAirportExist", arguments.airport);
		sqlString = "SELECT faa_code "
					& " FROM DL_AIRPORTS "
					& " WHERE faa_code = :faa_code";
		queryResult = variables.queryHandler.executeQuery(queryHandler, sqlString);
		return queryResult.getResult().recordCount;
	}

	private boolean function createAirport(required dotlog.model.beans.airport airport)
	{
		var queryHandler = getQueryHandler("createAirport", arguments.airport);
		sqlString = "INSERT INTO DL_AIRPORTS " 
					& "(faa_code, hub_code, airport_name, district_name, enabled) "
					& "VALUES (:faa_code, :hub_code, :airport_name, :districtName, :enabled)";
		queryResult = variables.queryHandler.executeQuery(queryHandler, sqlString);
		return len(queryResult.getPrefix().rowID); //returns a number - need to fix?
	}

	private boolean function updateAirport(required dotlog.model.beans.airport airport)
	{
		var queryHandler = getQueryHandler("updateAirport", arguments.airport);
		sqlString = "UPDATE DL_AIRPORTS SET "
					& "hub_code = :hub_code, airport_name = :airport_name, district_name = :districtName, enabled = :enabled "
					& "WHERE faa_code = :faa_code";
		queryResult = variables.queryHandler.executeQuery(queryHandler, sqlString);
		return len(queryResult.getPrefix().recordCount);
	}

	private base function getQueryHandler(required string queryName, required dotlog.model.beans.airport airport)
	{
		var queryHandler = new query();

		queryHandler.setName(arguments.queryName);

		queryHandler.addParam(name = "faa_code", value = arguments.airport.getAirportCode(), cfsqltype = "cf_sql_varchar");
		queryHandler.addParam(name = "hub_code", value = arguments.airport.getHubCode(), cfsqltype = "cf_sql_varchar");
		queryHandler.addParam(name = "airport_name", value = arguments.airport.getAirportName(), cfsqltype = "cf_sql_varchar");
		queryHandler.addParam(name = "districtName", value = arguments.airport.getDistrictName(), cfsqltype = "cf_sql_varchar");
		queryHandler.addParam(name = "enabled", value = arguments.airport.isEnabled(), cfsqltype = "cf_sql_number");

		return queryHandler;
	}
}