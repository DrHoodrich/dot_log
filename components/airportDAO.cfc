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

				DSname = variables.instance.datasource.getDSName();
		DSusername = variables.instance.datasource.getUsername();
		DSpassword = variables.instance.datasource.getPassword();

		queryService.setName("fetchChildAirports");
		queryService.setDataSource(variables.instance.datasource.getDSName());
		queryService.setUsername(DSusername);
		queryService.setPassword(DSpassword);

		queryService.addParam(name = "faa_code", value = arguments.faaCode, cfsqltype = "cf_sql_varchar");
		queryResult = queryService.execute(sql = "SELECT faa_code, parent_faa_code, airport_name, enabled 
			FROM DL_AIRPORTS WHERE faa_code = :faa_code");
		result = queryResult.getResult();
		
		return new Airport(FAACode = result["faa_code"][1],
							parentFAACode = result["parent_faa_code"][1],
							airportName = result["airport_name"][1],
							enabled = result["enabled"][1]);
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
		queryResult = queryHandler.execute(sql = "SELECT faa_code FROM DL_AIRPORTS WHERE faa_code = :faa_code");
		return queryResult.getResult().recordCount;
	}

	private boolean function createAirport(required airport airport)
	{
		var queryHandler = getQueryHandler("createAirport", arguments.airport);

		try {
			queryResult = queryHandler.execute(sql = "INSERT INTO DL_AIRPORTS 
						(faa_code, parent_faa_code, airport_name, enabled) 
						VALUES (:faa_code, :parent_faa_code, :airport_name, :enabled)");
		} catch (database excpt) {
			writeDump(excpt.cause.message); // TODO give a nice errors to user, like if FAA already exists.
			return false;
		}
		return true;
	}

	private boolean function updateAirport(required airport airport)
	{
		var queryHandler = getQueryHandler("updateAirport", arguments.airport);

		try {
			queryResult = queryHandler.execute(sql = "UPDATE DL_AIRPORTS SET
						parent_faa_code = parent_faa_code, airport_name = :airport_name, enabled = :enabled 
						WHERE faa_code = :faa_code");
		} catch (database excpt) {
			writeDump(excpt.cause.message); // TODO give a nice errors to user, like if FAA already exists.
			return false;
		}
		return true;
	}

	private base function getQueryHandler(required string queryName, required airport airport)
	{
		var queryService = new query();

		queryService.setName(arguments.queryName);
		queryService.setDataSource(variables.instance.datasource.getDSName());
		queryService.setUsername(variables.instance.datasource.getUsername());
		queryService.setPassword(variables.instance.datasource.getPassword());

		queryService.addParam(name = "faa_code", value = arguments.airport.getFAACode(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "parent_faa_code", value = arguments.airport.getParentAirportFAACode(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "airport_name", value = arguments.airport.getAirportName(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "enabled", value = arguments.airport.isEnabled(), cfsqltype = "cf_sql_number");

		return queryService;
	}
}