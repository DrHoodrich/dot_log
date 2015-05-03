component UserGateway
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

	public query function getAllUsers()
	{
		return filterUsers();
	} 

	public array function filterUsers(struct searchFilter=structNew())
	{
		var queryService = new query();
		queryService.setName("fetchUsers");

		sqlString = "SELECT username, first_name, last_name, faa_code, user_permissions, enabled, email_addr "
					& "FROM DL_USERS "
					& "WHERE 1 = 1 ";

		if ( !structIsEmpty(searchFilter) ) {
			if ( structKeyExists(searchFilter, "lastName") ) {
				queryService.addParam(name = "last_name", value = "%"&arguments.searchFilter.lastName&"%", cfsqltype = "cf_sql_varchar");
				sqlString &= " AND last_name LIKE :last_name";
			}
			if ( structKeyExists(searchFilter, "airportCode") ) {
				queryService.addParam(name = "faa_code", value = arguments.searchFilter.airportCode, cfsqltype = "cf_sql_varchar");
				sqlString &= " AND faa_code LIKE :faa_code";
			}
		}
		var queryResult = variables.instance.queryHandler.executeQuery(queryService, sqlString);
		var result = queryResult.getResult();

		var userObjects = [];
		for (var ii = 1; ii <= result.RecordCount; ++ii) {
			 objUser = new dotlog.model.beans.user(username = result["username"][ii],
														firstName= result["FIRST_NAME"][ii],
														lastName = result["LAST_NAME"][ii],
														airportCode = result["FAA_CODE"][ii],
														permissions = result["USER_PERMISSIONS"][ii],
														enabled = result["ENABLED"][ii],
														emailAddr = result["EMAIL_ADDR"][ii]);
			 arrayAppend(userObjects, objUser);
		}
		return userObjects;
	}
}