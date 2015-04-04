component UserGateway
{
	variables.instance = {
		datasource = ''
	};

	public UserGateway function init(required dotlog.components.datasource datasource)
	{
		variables.instance.datasource = arguments.datasource;
		return this;
	}

	public query function getUsersByAirportFAACode(required string faaCode)
	{
		var queryFilter = { faaCode = arguments.faaCode };
		return filterUsers(queryFilter);

		DSname = variables.instance.datasource.getDSName();
		DSusername = variables.instance.datasource.getUsername();
		DSpassword = variables.instance.datasource.getPassword();

		var queryService = new query();

		queryService.setName("fetchUsers");
		queryService.setDataSource(variables.instance.datasource.getDSName());
		queryService.setUsername(DSusername);
		queryService.setPassword(DSpassword);

		queryService.addParam(name = "faa_code", value = arguments.faaCode, cfsqltype = "cf_sql_varchar");
		queryResult = queryService.execute(sql = "SELECT username, first_name, last_name, faa_code, user_permissions, enabled 
			FROM DL_USERS 
			WHERE faa_code = :faa_code");
		result = queryResult.getResult();
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
		writeDump(arguments);
		var userObjects = [];

		DSname = variables.instance.datasource.getDSName();
		DSusername = variables.instance.datasource.getUsername();
		DSpassword = variables.instance.datasource.getPassword();

		var queryService = new query();

		queryService.setName("fetchUsers");
		queryService.setDataSource(variables.instance.datasource.getDSName());
		queryService.setUsername(DSusername);
		queryService.setPassword(DSpassword);

		

		sqlString = "SELECT username, first_name, last_name, faa_code, user_permissions, enabled FROM DL_USERS WHERE 1 = 1 ";

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
		writeDump(sqlString);
		writeDump(queryService);
		queryResult = queryService.execute(sql=sqlString);
		return queryResult.getResult();
	}
}