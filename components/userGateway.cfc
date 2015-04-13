component UserGateway
{
	variables.instance = {
		datasource = '',
		queryHandler = ''
	};

	public UserGateway function init(required dotlog.components.datasource datasource)
	{
		variables.instance.datasource = arguments.datasource;
		variables.instance.queryHandler = new queryHandler();
		return this;
	}

	public query function getUsersByAirportFAACode(required string faaCode)
	{
		var queryFilter = { faaCode = arguments.faaCode };
		return filterUsers(queryFilter);
	} 

	public query function getAllUsers()
	{
		return filterUsers();
	} 

	public query function getUsersByLastName(required string lastName)
	{
		var queryFilter = { lastname = arguments.lastName };
		return filterUsers(queryFilter);	
	} 	

	public query function filterUsers(struct searchFilter=structNew())
	{
		var queryService = new query();
		queryService.setName("fetchUsers");
		queryService = setQueryHandlerDatasource(queryService);

		sqlString = "SELECT username, first_name, last_name, faa_code, user_permissions, enabled "
					& "FROM DL_USERS "
					& "WHERE 1 = 1 ";

		if ( !structIsEmpty(searchFilter) ) {
			if ( structKeyExists(searchFilter, "lastName") ) {
				queryService.addParam(name = "last_name", value = "%"&arguments.searchFilter.lastName&"%", cfsqltype = "cf_sql_varchar");	
				sqlString = sqlString & " AND last_name LIKE :last_name";
			}
			if ( structKeyExists(searchFilter, "faaCode") ) {
				queryService.addParam(name = "faa_code", value = arguments.searchFilter.faaCode, cfsqltype = "cf_sql_varchar");
				sqlString = sqlString & " AND faa_code LIKE :faa_code";
			}
		}
		queryResult = executeQuery(queryService, sqlString);
		return queryResult.getResult();
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