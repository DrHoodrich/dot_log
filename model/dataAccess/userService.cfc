component UserService
{
	variables.instance = {
		userDAO = '',
		userGW = ''
	};

	public UserService function init(required dotlog.model.beans.datasource datasource)
	{
		variables.instance.userDAO = new dotlog.model.dataAccess.userDAO(arguments.datasource);
		variables.instance.userGW = new dotlog.model.dataAccess.userGateway(arguments.datasource);
		return this;
	}


	public array function getUsersByAirportCode(required string airportCode)
	{
		var searchParam = {
			airportCode = arguments.airportCode
		};
		return variables.instance.userGW.filterUsers(searchParam);
	} 

	public boolean function saveUser(required dotlog.model.beans.user user)
	{
		return variables.instance.userDAO.saveUser(arguments.user);
	} 

	public dotlog.model.beans.user function getUserByUsername(required string username)
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