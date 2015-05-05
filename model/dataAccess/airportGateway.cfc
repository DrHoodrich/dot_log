component AirportGateway
{
	variables.queryHandler = '';
	
	public airportGateway function init(required dotlog.model.beans.datasource datasource)
	{
		variables.queryHandler = new dotlog.model.queryHandler(arguments.datasource);
		return this;
	}

	public array function getChildAirports(required string airportCode)
	{
		var childAirports = [];

		var queryService = new query();

		queryService.setName("fetchChildAirports");
		queryService.addParam(name = "parent_faa_code", value = arguments.airportCode, cfsqltype = "cf_sql_varchar");

		var sqlString = "SELECT faa_code, parent_faa_code, airport_name, enabled "
						& " FROM DL_AIRPORTS "
						& " WHERE parent_faa_code = :parent_faa_code";
		var queryResult = variables.queryHandler.executeQuery(queryService, sqlString);
		var result = queryResult.getResult();

		for (var ii = 1; ii <= result.RecordCount; ++ii) {
			 childAirport = new dotlog.model.beans.airport(airportCode = result["faa_code"][ii],
															parentairportCode = result["parent_faa_code"][ii],
															airportName = result["airport_name"][ii],
															enabled = result["enabled"][ii]);
							
			 arrayAppend(childAirports, childAirport);
		}
		return childAirports;
	}
}