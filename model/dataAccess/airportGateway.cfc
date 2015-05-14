component AirportGateway extends = "dotlog.model.dataAccess.gateway"
{
	variables.queryHandler = '';
	
	public airportGateway function init(required dotlog.model.beans.datasource datasource)
	{
		variables.queryHandler = new dotlog.model.queryHandler(arguments.datasource);
		return this;
	}

	public array function filter(struct searchFilter=structNew())
	{
		var queryService = new query();
		var sqlString = "SELECT faa_code, hub_code, airport_name, district_name, enabled "
						& " FROM DL_AIRPORTS "
						& " WHERE 1 = 1 ";

		if ( structKeyExists(searchFilter, "parentAirportCode") ) {
			if ( structKeyExists(searchFilter,"getChildren") ) {
				queryService.setName("fetchChildAirports");
				queryService.addParam(name = "hub_code", value = arguments.searchFilter.parentAirportCode, cfsqltype = "cf_sql_varchar");
				sqlString &= " AND hub_code = :hub_code";

			}
		}
		var queryResult = queryHandler.executeQuery(queryService, sqlString);
		var result = queryResult.getResult();
		var airports = [];
		for (var ii = 1; ii <= result.RecordCount; ++ii) {
			 airport = new dotlog.model.beans.airport(airportCode = result["faa_code"][ii],
															hubCode = result["hub_code"][ii],
															airportName = result["airport_name"][ii],
															districtName = result["district_name"][ii],
															enabled = result["enabled"][ii]);
							
			 arrayAppend(airports, airport);
		}
		return airports;
	}
}