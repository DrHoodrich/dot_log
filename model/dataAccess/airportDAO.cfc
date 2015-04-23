component AirportDAO
{
	variables.instance = {
		datasource = '',
		queryHandler = ''
	};

	public airportDAO function init(required dotlog.model.beans.datasource datasource)
	{
		variables.instance.datasource = arguments.datasource;
		variables.instance.queryHandler = new dotlog.model.queryHandler();
		return this;
	}

	public dotlog.model.beans.airport function getAirportByAirportCode(required string airportCode)
	{
		var queryHandler = new query();

		queryHandler = setQueryHandlerDatasource(queryHandler);
		queryHandler.setName("fetchChildAirports");
		queryHandler.addParam(name = "faa_code", value = arguments.airportCode, cfsqltype = "cf_sql_varchar");

		sqlString = "SELECT faa_code, parent_faa_code, airport_name, enabled "
					& "FROM DL_AIRPORTS WHERE faa_code = :faa_code";

		queryResult = variables.instance.queryHandler.executeQuery(queryHandler, sqlString).getResult();
		
		return new dotlog.model.beans.airport(airportCode = queryResult["faa_code"][1],
											parentAirportCode = queryResult["parent_faa_code"][1],
											airportName = queryResult["airport_name"][1],
											enabled = queryResult["enabled"][1]);
	}

	public boolean function saveAirport(required dotlog.model.beans.airport airport)
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
		sqlString = "SELECT faa_code FROM DL_AIRPORTS "
					&"WHERE faa_code = :faa_code";
		queryResult = variables.instance.queryHandler.executeQuery(queryHandler, sqlString);
		return queryResult.getResult().recordCount;
	}

	private boolean function createAirport(required dotlog.model.beans.airport airport)
	{
		var queryHandler = getQueryHandler("createAirport", arguments.airport);
		sqlString = "INSERT INTO DL_AIRPORTS " 
					& "(faa_code, parent_faa_code, airport_name, enabled) "
					& "VALUES (:faa_code, :parent_faa_code, :airport_name, :enabled)";
		queryResult = variables.instance.queryHandler.executeQuery(queryHandler, sqlString);
		return len(queryResult.getPrefix().rowID); //returns a number - need to fix?
	}

	private boolean function updateAirport(required dotlog.model.beans.airport airport)
	{
		var queryHandler = getQueryHandler("updateAirport", arguments.airport);
		sqlString = "UPDATE DL_AIRPORTS SET "
					& "parent_faa_code = :parent_faa_code, airport_name = :airport_name, enabled = :enabled "
					& "WHERE faa_code = :faa_code";
		queryResult = variables.instance.queryHandler.executeQuery(queryHandler, sqlString);
		return len(queryResult.getPrefix().recordCount);
	}

	private base function getQueryHandler(required string queryName, required dotlog.model.beans.airport airport)
	{
		var queryHandler = new query();

		queryHandler = setQueryHandlerDatasource(queryHandler);
		queryHandler.setName(arguments.queryName);

		queryHandler.addParam(name = "faa_code", value = arguments.airport.getAirportCode(), cfsqltype = "cf_sql_varchar");
		queryHandler.addParam(name = "parent_faa_code", value = arguments.airport.getParentAirportCode(), cfsqltype = "cf_sql_varchar");
		queryHandler.addParam(name = "airport_name", value = arguments.airport.getAirportName(), cfsqltype = "cf_sql_varchar");
		queryHandler.addParam(name = "enabled", value = arguments.airport.isEnabled(), cfsqltype = "cf_sql_number");

		return queryHandler;
	}

	private base function setQueryHandlerDatasource(required base queryHandler)
	{
		var returnedQueryHandler = arguments.queryHandler;
		returnedQueryHandler.setDataSource(variables.instance.datasource.getDSName());
		returnedQueryHandler.setUsername(variables.instance.datasource.getUsername());
		returnedQueryHandler.setPassword(variables.instance.datasource.getPassword());
		return returnedQueryHandler;
	}
}
