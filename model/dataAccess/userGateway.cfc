component UserGateway extends = "dotlog.model.dataAccess.gateway"
{
	variables.instance = {
		datasource = '',
		queryHandler = ''
	};

	public UserGateway function init(required dotlog.model.beans.datasource datasource)
	{
		variables.instance.queryHandler = new dotlog.model.queryHandler(arguments.datasource);
		return this;
	}

	public query function getUsersByAirportCode(required string airportCode)
	{
		var queryFilter = { airportCode = arguments.airportCode };
		return filterUsers(queryFilter);
	} 

	public array function filter(struct searchFilter=structNew())
	{
		var queryService = new query();
		queryService.setName("fetchUsers");

		sqlString = " SELECT username, first_name, last_name, faa_code, user_permissions, enabled, district_manager, region_manager, email_addr "
					& "FROM DL_USERS "
					& "WHERE 1 = 1 ";

		if ( !structIsEmpty(searchFilter) ) {
			queryService.setName("filterUsers");
			if ( structKeyExists(searchFilter, "username") ) {
				queryService.addParam(name = "username", value = arguments.searchFilter.username, cfsqltype = "cf_sql_varchar");
				sqlString &= " AND username = :username";
			}
			if ( structKeyExists(searchFilter, "firstName") ) {
				queryService.addParam(name = "firstName", value = "%"&arguments.searchFilter.firstName&"%", cfsqltype = "cf_sql_varchar");
				sqlString &= " AND first_name LIKE :firstName";
			}
			if ( structKeyExists(searchFilter, "lastName") ) {
				queryService.addParam(name = "lastName", value = "%"&arguments.searchFilter.lastName&"%", cfsqltype = "cf_sql_varchar");
				sqlString &= " AND last_name LIKE :lastName";
			}
			if ( structKeyExists(searchFilter, "airportCode") ) {
				queryService.addParam(name = "airportCode", value = arguments.searchFilter.airportCode, cfsqltype = "cf_sql_varchar");
				sqlString &= " AND faa_code LIKE :airportCode";
			}
			if ( structKeyExists(searchFilter, "emailAddr") ) {
				queryService.addParam(name = "emailAddr", value = arguments.searchFilter.emailAddr, cfsqltype = "cf_sql_varchar");
				sqlString &= " AND faa_code LIKE :emailAddr";
			}
			if ( structKeyExists(searchFilter, "permission") ) {
				queryService.addParam(name = "permissions", value = arguments.searchFilter.permission, cfsqltype = "cf_sql_number");	
				sqlString &= " AND user_permissions = :permissions";
			}
			if ( structKeyExists(searchFilter, "regionManager") ) {
				queryService.addParam(name = "regionManager", value = arguments.searchFilter.regionManager, cfsqltype = "cf_sql_number");	
				sqlString &= " AND region_manager = :regionManager";
			}
			if ( structKeyExists(searchFilter, "districtManager") ) {
				queryService.addParam(name = "districtManager", value = arguments.searchFilter.districtManager, cfsqltype = "cf_sql_number");	
				sqlString &= " AND district_manager = :districtManager";
			}
		} else {
			queryService.setName("allUsers");
		}
		var queryResult = variables.instance.queryHandler.executeQuery(queryService, sqlString);
		var result = queryResult.getResult();

		var userObjects = [];
		for (var ii = 1; ii <= result.RecordCount; ++ii) {
			 user = new dotlog.model.beans.user(username = result["username"][ii],
														firstName= result["FIRST_NAME"][ii],
														lastName = result["LAST_NAME"][ii],
														airportCode = result["FAA_CODE"][ii],
														permissions = result["USER_PERMISSIONS"][ii],
														enabled = result["ENABLED"][ii],
														districtManager = result["district_manager"][ii],
														regionManager = result["region_manager"][ii],
														emailAddr = result["EMAIL_ADDR"][ii]);
			 arrayAppend(userObjects, user);
		}
		return userObjects;
	}
}