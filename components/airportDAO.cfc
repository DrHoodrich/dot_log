component AirportDAO
{
	variables.instance = {
		datasource = ''
	};

	public airportDAO function init(required dotlog.components.datasource datasource)
	{
		variables.instance.datasource = arguments.datasource;
		return this;
	}

	public airport function getAirportByFAACode(required string faaCode)
	{
		var queryService = new query();

		queryService = setQueryHandlerDatasource(queryService);		
		queryService.setName("fetchChildAirports");
		queryService.addParam(name = "faa_code", value = arguments.faaCode, cfsqltype = "cf_sql_varchar");

		sqlString = "SELECT faa_code, parent_faa_code, airport_name, enabled "
					& "FROM DL_AIRPORTS WHERE faa_code = :faa_code";

		queryResult = executeQuery(queryService, sqlString).getResult();
		
		airport = new Airport(FAACode = queryResult["faa_code"][1],
							parentFAACode = queryResult["parent_faa_code"][1],
							airportName = queryResult["airport_name"][1],
							enabled = queryResult["enabled"][1]);
		return airport;
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
		queryResult = executeQuery(queryHandler, sqlString);
		return queryResult.getResult().recordCount;
	}

	private boolean function createAirport(required airport airport)
	{
		var queryHandler = getQueryHandler("createAirport", arguments.airport);
		sqlString = "INSERT INTO DL_AIRPORTS " 
					& "(faa_code, parent_faa_code, airport_name, enabled) "
					& "VALUES (:faa_code, :parent_faa_code, :airport_name, :enabled)";
		queryResult = executeQuery(queryHandler, sqlString);
		return len(queryResult.getPrefix().rowID); //returns a number - need to fix?
	}

	private boolean function updateAirport(required airport airport)
	{
		var queryHandler = getQueryHandler("updateAirport", arguments.airport);
		sqlString = "UPDATE DL_AIRPORTS SET "
					& "parent_faa_code = parent_faa_code, airport_name = :airport_name, enabled = :enabled "
					& "WHERE faa_code = :faa_code";
		queryResult = executeQuery(queryHandler, sqlString);
		return len(queryResult.getPrefix().recordCount);
	}

	private base function getQueryHandler(required string queryName, required airport airport)
	{
		var queryService = new query();

		queryService = setQueryHandlerDatasource(queryService);
		queryService.setName(arguments.queryName);		

		queryService.addParam(name = "faa_code", value = arguments.airport.getFAACode(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "parent_faa_code", value = arguments.airport.getParentAirportFAACode(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "airport_name", value = arguments.airport.getAirportName(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "enabled", value = arguments.airport.isEnabled(), cfsqltype = "cf_sql_number");

		return queryService;
	}

	private result function executeQuery(required base queryHandler, required string sqlString)
	{
		queryResult = '';
		transaction action="begin" {
			try {
				queryResult = arguments.queryHandler.execute(sql = arguments.sqlString);				
			} catch (database exception) {
				transactionRollBack();
				// TODO - how to handle this exception
			}
			transactionCommit();
		}
		return queryResult;
	}

	private base function setQueryHandlerDatasource(required base queryHandler)
	{		
		var returnedQueryHandler = queryHandler;
		returnedQueryHandler.setDataSource(variables.instance.datasource.getDSName());
		returnedQueryHandler.setUsername(variables.instance.datasource.getUsername());
		returnedQueryHandler.setPassword(variables.instance.datasource.getPassword());
		return returnedQueryHandler;
	}
}