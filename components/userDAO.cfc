component UserDAO
{
	variables.instance = {
		datasource = '',
		queryHandler = ''
	};

	public userDAO function init(required dotlog.components.datasource datasource)
	{
		variables.instance.datasource = arguments.datasource;
		variables.instance.queryHandler = new queryHandler();
		return this;
	}

	public array function getUsersByAirportFAACode(required string faaCode)
	{
		var queryHandler = new query();
		queryHandler = setQueryHandlerDatasource(queryHandler);
		queryHandler.setName("fetchUsers");	
		queryHandler.addParam(name = "faa_code", value = arguments.faaCode, cfsqltype = "cf_sql_varchar");

		sqlString = "SELECT username, first_name, last_name, faa_code, user_permissions, enabled, email_addr "
					& "FROM DL_USERS "
					& "WHERE faa_code = :faa_code";

		queryResult = variables.instance.queryHandler.executeQuery(queryHandler, sqlString);
		result = queryResult.getResult();

		var userObjects = [];
		for (var ii = 1; ii <= result.RecordCount; ++ii) {
			 objUser = new User(username = result["username"][ii],
							firstName= result["FIRST_NAME"][ii],
							lastName = result["LAST_NAME"][ii],
							faaCode = result["FAA_CODE"][ii],
							permissions = result["USER_PERMISSIONS"][ii],
							enabled = result["ENABLED"][ii],
							emailAddr = result["EMAIL_ADDR"][ii]);
			 arrayAppend(userObjects, objUser);
		}
		return userObjects;
	} 

	public User function getUserByUsername(required string username)
	{
		var queryHandler = new query();

		queryHandler.setName("fetchUser");
		queryHandler = setQueryHandlerDatasource(queryHandler);
		queryHandler.addParam(name = "username", value = arguments.username, cfsqltype = "cf_sql_varchar");

		sqlString = "SELECT username, first_name, last_name, faa_code, user_permissions, enabled, email_addr "
					& "FROM DL_USERS "
					& "WHERE username = :username";
		queryResult = variables.instance.queryHandler.executeQuery(queryHandler, sqlString);
		result = queryResult.getResult();

		var objUser = '';
		if (result.RecordCount) {
			objUser = new User(username = result["username"][1],
							firstName= result["FIRST_NAME"][1],
							lastName = result["LAST_NAME"][1],
							faaCode = result["FAA_CODE"][1],
							permissions = result["USER_PERMISSIONS"][1],
							enabled = result["ENABLED"][1],
							emailAddr = result["EMAIL_ADDR"][1]);
		}
		return objUser;
	}

	public boolean function saveUser(required user user)
	{
		if ( userExists(user) ) {
			return updateUser(arguments.user);
		} else {
			return createUser(arguments.user);
		}
	}

	private boolean function updateUser(required user user)
	{
		var queryHandler = getQueryHandler("updateUser", arguments.user);

		sqlString = "UPDATE DL_USERS SET "
					& "USERNAME = :username, FIRST_NAME = :firstName, LAST_NAME = :lastName, FAA_CODE = :airportFAACode, USER_PERMISSIONS = :permissions,  ENABLED = :enabled "
					& "WHERE USERNAME = :username";
		queryResult = variables.instance.queryHandler.executeQuery(queryHandler, sqlString);

		return len(queryResult.getPrefix().recordCount);
	}

	private boolean function createUser(required user user)
	{
		queryHandler = getQueryHandler("createUser", user);

		sqlString = "INSERT INTO DL_USERS "
					& "(USERNAME, FIRST_NAME, LAST_NAME, FAA_CODE, USER_PERMISSIONS, EMAIL_ADDR, ENABLED) "
					& "VALUES (:username, :firstName, :lastName, :airportFAACode, :permissions, :emailAddr, :enabled)";
		queryResult = variables.instance.queryHandler.executeQuery(queryHandler, sqlString);
		return len(queryResult.getPrefix().rowID); //returns a number - need to fix?
	}

	private boolean function userExists(required user user)
	{
		var queryHandler = getQueryHandler("SeeIfUserExists", arguments.user);

		sqlString = "SELECT username "
					& "FROM DL_USERS "
					& "WHERE username = :username"; 
		queryResult = variables.instance.queryHandler.executeQuery(queryHandler, sqlString);
		return queryResult.getResult().recordCount;
	}

	private base function getQueryHandler(required string queryName, required user user)
	{
		var queryHandler = new query();

		queryHandler.setName(arguments.queryName);
		queryHandler = setQueryHandlerDatasource(queryHandler);

		queryHandler.addParam(name = "username", value = arguments.user.getUsername(), cfsqltype = "cf_sql_varchar");
		queryHandler.addParam(name = "firstName", value = arguments.user.getFirstName(), cfsqltype = "cf_sql_varchar");
		queryHandler.addParam(name = "lastName", value = arguments.user.getLastName(), cfsqltype = "cf_sql_varchar");
		queryHandler.addParam(name = "airportFAACode", value = arguments.user.getAirportFAACode(), cfsqltype = "cf_sql_varchar");
		queryHandler.addParam(name = "permissions", value = arguments.user.getPermissions(), cfsqltype = "cf_sql_number");
		queryHandler.addParam(name = "emailAddr", value = arguments.user.getPermissions(), cfsqltype = "cf_sql_varchar");
		queryHandler.addParam(name = "enabled", value = user.isEnabled(), cfsqltype = "cf_sql_number");

		return queryHandler;
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