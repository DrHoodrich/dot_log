component UserService extends="CoreUtils"
{
	variables.instance = {
		userDAO = '',
		userGW = ''
	};

	public UserService function init(required dotlog.components.datasource datasource)
	{
		variables.instance.userDAO = new dotlog.components.userDAO(arguments.datasource);
		variables.instance.userGW = new dotlog.components.userGateway(arguments.datasource);
		return this;
	}


	public array function getUsersByAirportFAACode(required string faaCode)
	{
		var searchParam = {
			faaCode = arguments.faaCode
		};
		return variables.instance.userGW.filterUsers(searchParam);
	} 

	public boolean function saveUser(required user user)
	{
		return variables.instance.userDAO.saveUser(arguments.user);
	} 

	public user function getUserByUsername(required string username)
	{
		return variables.instance.userDAO.getUserByUsername(arguments.username);
	}

	public query function getAllUsers()
	{
		return variables.instance.userGW.getAllUsers();
	}

	public query function getUsersByLastName(required string lastNameFilter)
	{
		var queryFilter = { lastname = arguments.lastNameFilter };
		return variables.instance.userGW.filterUsers(queryFilter);
	}
}