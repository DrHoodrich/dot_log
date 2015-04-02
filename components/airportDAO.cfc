component UserDAO
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

		writeDump(result);

		for (var ii = 1; ii <= result.RecordCount; ++ii) {
			 childAirport = new Airport(FAACode = result["faa_code"][ii],
										parentFAACode = result["parent_faa_code"][ii],
										airportName = result["airport_name"][ii],
										enabled = result["enabled"][ii]);
							
			 arrayAppend(childAirports, childAirport);
		}
		return childAirports;
	} 
}