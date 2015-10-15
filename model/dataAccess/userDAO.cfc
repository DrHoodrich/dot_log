component UserDAO extends = "dotlog.model.dataAccess.DAO"
{
	variables.queryHandler = '';

	public dotlog.model.dataAccess.userDAO function init(required dotlog.model.beans.datasource datasource)
	{
		variables.queryHandler = new dotlog.model.queryHandler(datasource);
		return this;
	}

	public boolean function save(required dotlog.model.beans.user user)
	{
		if ( userExists(user) ) {
			return updateUser(arguments.user);
		} else {
			return createUser(arguments.user);
		}
	}

	private boolean function updateUser(required dotlog.model.beans.user user)
	{
		var queryHandler = getQueryHandler("updateUser", arguments.user);

		sqlString = "UPDATE DL_USERS SET "
					& "USERNAME = LOWER(:username), FIRST_NAME = :firstName,
													LAST_NAME = :lastName, 
													FAA_CODE = :airportCode, 
													USER_PERMISSIONS = :permissions,  
													ENABLED = :enabled, 
													DISTRICT_MANAGER = :districtManager, 
													REGION_MANAGER = :regionManager "
					& "WHERE USERNAME = :username";

		queryResult = variables.queryHandler.executeQuery(queryHandler, sqlString);
		return len(queryResult.getPrefix().recordCount);
	}

	private boolean function createUser(required dotlog.model.beans.user user)
	{
		var queryHandler = getQueryHandler("createUser", arguments.user);

		sqlString = "INSERT INTO DL_USERS "
					& "(USERNAME, FIRST_NAME, LAST_NAME, FAA_CODE, USER_PERMISSIONS, EMAIL_ADDR, ENABLED, DISTRICT_MANAGER, REGION_MANAGER) "
					& "VALUES (LOWER(:username), :firstName, :lastName, :airportCode, :permissions, :emailAddr, :enabled, :districtManager, :regionManager)";
		queryResult = variables.queryHandler.executeQuery(queryHandler, sqlString);
		return len(queryResult.getPrefix().rowID); //returns a number - need to fix?
	}

	private boolean function userExists(required dotlog.model.beans.user user)
	{
		var queryHandler = getQueryHandler("userExists", arguments.user);

		sqlString = "SELECT username "
					& "FROM DL_USERS "
					& "WHERE username = :username"; 
		queryResult = variables.queryHandler.executeQuery(queryHandler, sqlString);
		return queryResult.getResult().recordCount;
	}

	private base function getQueryHandler(required string queryName, required dotlog.model.beans.user user)
	{
		var queryHandler = new query();

		queryHandler.setName(arguments.queryName);
		queryHandler.addParam(name = "username", value = arguments.user.getUsername(), cfsqltype = "cf_sql_varchar");
		queryHandler.addParam(name = "firstName", value = arguments.user.getFirstName(), cfsqltype = "cf_sql_varchar");
		queryHandler.addParam(name = "lastName", value = arguments.user.getLastName(), cfsqltype = "cf_sql_varchar");
		queryHandler.addParam(name = "airportCode", value = arguments.user.getAirportCode(), cfsqltype = "cf_sql_varchar");
		queryHandler.addParam(name = "permissions", value = arguments.user.getPermissions(), cfsqltype = "cf_sql_number");
		queryHandler.addParam(name = "emailAddr", value = arguments.user.getEmailAddr(), cfsqltype = "cf_sql_varchar");
		queryHandler.addParam(name = "enabled", value = user.isEnabled(), cfsqltype = "cf_sql_number");
		queryHandler.addParam(name = "districtManager", value = user.isDistrictManager(), cfsqltype = "cf_sql_number");
		queryHandler.addParam(name = "regionManager", value = user.isRegionManager(), cfsqltype = "cf_sql_number");
		return queryHandler;
	}
}
