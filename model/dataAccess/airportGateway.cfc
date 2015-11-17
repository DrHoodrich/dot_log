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
		var sqlString = "SELECT faa_code, hub_code, airport_name, district_id, enabled "
						& " FROM DL_AIRPORTS "
						& " WHERE 1 = 1 ";

		if ( !structIsEmpty(searchFilter) ) {
			queryService.setName("filterAirports");
			if ( structKeyExists(searchFilter,"airportCode") ) {
				queryService.addParam(name = "airportCode", value = arguments.searchFilter.airportCode, cfsqltype = "cf_sql_varchar");
				sqlString &= " AND faa_code = :airportCode";
			}
			if ( structKeyExists(searchFilter,"hubCode") ) {
				queryService.addParam(name = "hubCode", value = arguments.searchFilter.hubCode, cfsqltype = "cf_sql_varchar");
				sqlString &= " AND hub_code = :hubCode";
			}
			if ( structKeyExists(searchFilter, "airportName") ) {
				queryService.addParam(name = "airportName", value = "%"&arguments.searchFilter.airportName&"%", cfsqltype = "cf_sql_varchar");	
				sqlString &= " AND LOWER(airport_name) LIKE LOWER(:airportName)";
			}
			if ( structKeyExists(searchFilter, "districtID") ) {
				queryService.addParam(name = "districtID", value = arguments.searchFilter.districtID, cfsqltype = "cf_sql_number");
				sqlString &= " AND district_id = :districtID";
				if ( structKeyExists(searchFilter,"hubAirports") ) {
					sqlString &= " AND hub_code = faa_code";
				}
			}
			if ( structKeyExists(searchFilter, "enabled") ) {
				queryService.addParam(name = "enabled", value = arguments.searchFilter.enabled, cfsqltype = "cf_sql_number");
				sqlString &= " AND enabled = :enabled";
			}
		} else {
			queryService.setName("getAllAirports");
		}
		var queryResult = queryHandler.executeQuery(queryService, sqlString);
		var result = queryResult.getResult();
		var airports = [];
		for (var ii = 1; ii <= result.RecordCount; ++ii) {
			 airport = new dotlog.model.beans.airport(airportCode = result["faa_code"][ii],
															hubCode = result["hub_code"][ii],
															airportName = result["airport_name"][ii],
															districtID = result["district_id"][ii],
															enabled = result["enabled"][ii]);
							
			 arrayAppend(airports, airport);
		}
		return airports;
	}
}