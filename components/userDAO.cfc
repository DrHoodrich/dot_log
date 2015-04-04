component UserDAO
{
	variables.instance = {
		datasource = ''
	};

	public userDAO function init(required dotlog.components.datasource datasource)
	{
		variables.instance.datasource = arguments.datasource;
		return this;
	}

	public array function getUsersByAirportFAACode(required string faaCode)
	{
		var userObjects = [];

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
			FROM DL_USERS WHERE faa_code = :faa_code");
		result = queryResult.getResult();

		for (var ii = 1; ii <= result.RecordCount; ++ii) {
			 objUser = new User(username = result["username"][ii],
							firstName= result["FIRST_NAME"][ii],
							lastName = result["LAST_NAME"][ii],
							faaCode = result["FAA_CODE"][ii],
							permissions = result["USER_PERMISSIONS"][ii],
							enabled = result["ENABLED"][ii]);
			 arrayAppend(userObjects, objUser);
		}
		return userObjects;
	} 

	public User function getUserByUsername(required string username)
	{
		var objUser = '';

		DSname = variables.instance.datasource.getDSName();
		DSusername = variables.instance.datasource.getUsername();
		DSpassword = variables.instance.datasource.getPassword();

		var queryService = new query();

		queryService.setName("fetchUser");
		queryService.setDataSource(variables.instance.datasource.getDSName());
		queryService.setUsername(DSusername);
		queryService.setPassword(DSpassword);

		queryService.addParam(name = "username", value = arguments.username, cfsqltype = "cf_sql_varchar");
		queryResult = queryService.execute(sql = "SELECT username, first_name, last_name, faa_code, user_permissions, enabled 
			FROM DL_USERS 
			WHERE username = :username");
		result = queryResult.getResult();

		if (result.RecordCount) {
			objUser = new User(username = result["username"][1],
							firstName= result["FIRST_NAME"][1],
							lastName = result["LAST_NAME"][1],
							faaCode = result["FAA_CODE"][1],
							permissions = result["USER_PERMISSIONS"][1],
							enabled = result["ENABLED"][1]);
		}
		return objUser;
	} 

	public boolean function saveUser(required user user)
	{
		if (userExists(user)) {
			return updateUser(arguments.user);
		} else {
			return createUser(arguments.user);
		}
	}

	public boolean function updateUser(required user user)
	{
		if (user.isEnabled()) {
			enableValue = 1;
		} else {
			enableValue = 0;
		}

		var queryService = new query();

		queryService.setName("createUser");
		queryService.setDataSource(variables.instance.datasource.getDSName());
		queryService.setUsername(variables.instance.datasource.getUsername());
		queryService.setPassword(variables.instance.datasource.getPassword());

		queryService.addParam(name = "username", value = arguments.user.getUsername(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "firstName", value = arguments.user.getFirstName(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "lastName", value = arguments.user.getLastName(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "airportFAACode", value = arguments.user.getAirportFAACode(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "permissions", value = arguments.user.getPermissions(), cfsqltype = "cf_sql_number");
		queryService.addParam(name = "enabled", value = enableValue, cfsqltype = "cf_sql_number");

		transaction action="begin"
		{
			try {
				queryResult = queryService.execute(sql = "UPDATE DL_USERS SET
					USERNAME = :username, FIRST_NAME = :firstName, LAST_NAME = :lastName, FAA_CODE = :airportFAACode, USER_PERMISSIONS = :permissions, ENABLED = :enabled 
					WHERE USERNAME = :username");
				return true;
			} catch (database excpt) {
				transactionRollback();
				return false;
			}
		}
	}

	public boolean function createUser(required user user)
	{
		if (user.isEnabled()) {
			enableValue = 1;
		} else {
			enableValue = 0;
		}

		queryService = new query();

		queryService.setName("createUser");
		queryService.setDataSource(variables.instance.datasource.getDSName());
		queryService.setUsername(variables.instance.datasource.getUsername());
		queryService.setPassword(variables.instance.datasource.getPassword());

		queryService.addParam(name = "username", value = arguments.user.getUsername(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "firstName", value = arguments.user.getFirstName(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "lastName", value = arguments.user.getLastName(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "airportFAACode", value = arguments.user.getAirportFAACode(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "permissions", value = arguments.user.getPermissions(), cfsqltype = "cf_sql_number");
		queryService.addParam(name = "enabled", value = enableValue, cfsqltype = "cf_sql_number");

		transaction action="begin"
		{
			try {
				queryResult = queryService.execute(sql = "INSERT INTO DL_USERS 
					(USERNAME, FIRST_NAME, LAST_NAME, FAA_CODE, USER_PERMISSIONS, ENABLED) 
					VALUES (:username, :firstName, :lastName, :airportFAACode, :permissions, :enabled)");
				return true;
			} catch (any excpt) {
				transactionRollback();
				return false;
			}
		}
	}

	public boolean function userExists(required user user)
	{
		var queryService = new query();
		queryService.setDataSource(variables.instance.datasource.getDSName());
		queryService.setUsername(variables.instance.datasource.getUsername());
		queryService.setPassword(variables.instance.datasource.getPassword());

		queryService.addParam(name = "username", value = user.getUsername(), cfsqltype = "cf_sql_varchar");
		queryResult = queryService.execute(sql = "SELECT count(1) username FROM DL_USERS WHERE username = :username"); 

		return queryResult.getResult().recordCount;
	}
}