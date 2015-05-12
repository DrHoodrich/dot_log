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
		var searchParam = { airportCode = arguments.airportCode };
		return variables.instance.userGW.filter(searchParam);
	} 

	public boolean function saveUser(required dotlog.model.beans.user user)
	{
		return variables.instance.userDAO.save(arguments.user);
	} 

	public dotlog.model.beans.user function getUserByUsername(required string username)
	{
		var searchParam = { username = arguments.username };
		return variables.instance.userDAO.search(searchParam);
	}

	public query function getUsersByLastName(required string lastNameFilter)
	{
		var queryFilter = { lastname = arguments.lastNameFilter };
		return variables.instance.userGW.filter(queryFilter);
	}
}