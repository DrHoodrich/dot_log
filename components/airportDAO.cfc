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

	public array function getChildAirports(required string faaCode)
	{
		var childAirports = [];

		DSname = variables.instance.datasource.getDSName();
		DSusername = variables.instance.datasource.getUsername();
		DSpassword = variables.instance.datasource.getPassword();

		var queryService = new query();

		queryService.setName("fetchChildAirports");
		queryService.setDataSource(variables.instance.datasource.getDSName());
		queryService.setUsername(DSusername);
		queryService.setPassword(DSpassword);

		queryService.addParam(name = "parent_faa_code", value = arguments.faaCode, cfsqltype = "cf_sql_varchar");
		queryResult = queryService.execute(sql = "SELECT faa_code, parent_faa_code, airport_name, enabled 
			FROM DL_AIRPORTS WHERE parent_faa_code = :parent_faa_code");
		result = queryResult.getResult();

		for (var ii = 1; ii <= result.RecordCount; ++ii) {
			 childAirport = new Airport(FAACode = result["faa_code"][ii],
										parentFAACode = result["parent_faa_code"][ii],
										airportName = result["airport_name"][ii],
										enabled = result["enabled"][ii]);
							
			 arrayAppend(childAirports, childAirport);
		}
		return childAirports;
	} 

	public boolean function saveAirport(required airport airport)
	{
		var queryService = new query();

		queryService.setName("createAirport");
		queryService.setDataSource(variables.instance.datasource.getDSName());
		queryService.setUsername(variables.instance.datasource.getUsername());
		queryService.setPassword(variables.instance.datasource.getPassword());

		queryService.addParam(name = "faa_code", value = arguments.airport.getFAACode(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "parent_faa_code", value = arguments.airport.getParentAirportFAACode(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "airport_name", value = arguments.airport.getAirportName(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "enabled", value = arguments.airport.isEnabled(), cfsqltype = "cf_sql_number");

		try {
			queryResult = queryService.execute(sql = "INSERT INTO DL_AIRPORTS 
						(faa_code, parent_faa_code, airport_name, enabled) 
						VALUES (:faa_code, :parent_faa_code, :airport_name, :enabled)");
		} catch (database excpt) {
			writeDump(excpt.cause.message); // TODO give a nice errors to user, like if FAA already exists.
			return false;
		}
		return true;
	}
}