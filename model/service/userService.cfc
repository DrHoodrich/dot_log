component UserService extends = "dotlog.model.service.service"
{
	variables.instance = {
		userDAO = '',
		userGW = ''
	};

	public UserService function init(required dotlog.model.dataAccess.DAO DAO,
									required dotlog.model.dataAccess.gateway GW)
	{
		variables.instance.userDAO = arguments.DAO;
		variables.instance.userGW = arguments.GW;
		return this;
	}

	public array function getUsersByAirportCode(required string airportCode)
	{
		var searchStruct = { airportCode = arguments.airportCode };
		return variables.instance.userGW.filter(searchStruct);
	} 

	public boolean function saveUser(required dotlog.model.beans.user user)
	{
		return variables.instance.userDAO.save(arguments.user);
	} 

	public dotlog.model.beans.user function getUserByUsername(required string username)
	{
		var user = '';
		var searchStruct = { username = arguments.username };
		var result = variables.instance.userGW.filter(searchStruct);
		if ( arrayLen(result) ) {
			user = result[1];
		}
		return user;
	}
}