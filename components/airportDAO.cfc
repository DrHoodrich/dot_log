component AirportDAO
{
	variables.instance = {
		datasource = '',
		queryHandler = ''
	};

	public airportDAO function init(required dotlog.components.datasource datasource)
	{
		variables.instance.datasource = arguments.datasource;
		variables.instance.queryHandler = new queryHandler();
		return this;
	}

	public airport function getAirportByFAACode(required string faaCode)
	{
		var queryHandler = new query();

		queryHandler = setQueryHandlerDatasource(queryHandler);
		queryHandler.setName("fetchChildAirports");
		queryHandler.addParam(name = "faa_code", value = arguments.faaCode, cfsqltype = "cf_sql_varchar");

		sqlString = "SELECT faa_code, parent_faa_code, airport_name, enabled "
					& "FROM DL_AIRPORTS WHERE faa_code = :faa_code";

		queryResult = variables.instance.queryHandler.executeQuery(queryHandler, sqlString).getResult();
		
		return new Airport(FAACode = queryResult["faa_code"][1],
							parentFAACode = queryResult["parent_faa_code"][1],
							airportName = queryResult["airport_name"][1],
							enabled = queryResult["enabled"][1]);
	}

	public boolean function saveAirport(required airport airport)
	{
		if ( airportExists(arguments.airport) ) {
			return updateAirport(arguments.airport);
		} else {
			return createAirport(arguments.airport);
		}
	}

	private boolean function airportExists(required airport airport)
	{
		var queryHandler = getQueryHandler("doesAirportExist", arguments.airport);
		sqlString = "SELECT faa_code FROM DL_AIRPORTS "
					&"WHERE faa_code = :faa_code";
		queryResult = variables.instance.queryHandler.executeQuery(queryHandler, sqlString);
		return queryResult.getResult().recordCount;
	}

	private boolean function createAirport(required airport airport)
	{
		var queryHandler = getQueryHandler("createAirport", arguments.airport);
		sqlString = "INSERT INTO DL_AIRPORTS " 
					& "(faa_code, parent_faa_code, airport_name, enabled) "
					& "VALUES (:faa_code, :parent_faa_code, :airport_name, :enabled)";
		queryResult = variables.instance.queryHandler.executeQuery(queryHandler, sqlString);
		return len(queryResult.getPrefix().rowID); //returns a number - need to fix?
	}

	private boolean function updateAirport(required airport airport)
	{
		var queryHandler = getQueryHandler("updateAirport", arguments.airport);
		sqlString = "UPDATE DL_AIRPORTS SET "
					& "parent_faa_code = parent_faa_code, airport_name = :airport_name, enabled = :enabled "
					& "WHERE faa_code = :faa_code";
		queryResult = variables.instance.queryHandler.executeQuery(queryHandler, sqlString);
		return len(queryResult.getPrefix().recordCount);
	}

	private base function getQueryHandler(required string queryName, required airport airport)
	{
		var queryHandler = new query();

		queryHandler = setQueryHandlerDatasource(queryHandler);
		queryHandler.setName(arguments.queryName);

		queryHandler.addParam(name = "faa_code", value = arguments.airport.getFAACode(), cfsqltype = "cf_sql_varchar");
		queryHandler.addParam(name = "parent_faa_code", value = arguments.airport.getParentAirportFAACode(), cfsqltype = "cf_sql_varchar");
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