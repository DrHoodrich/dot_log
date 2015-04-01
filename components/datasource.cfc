<cfscript>
component Datasource
{
	variables.instance = {
		DSName = '', username = '', password = ''
	};

	public Datasource function init(required string DSName, required string username, required string password)
	{
		variables.instance.DSName = arguments.DSName;
		variables.instance.username = arguments.username;
		variables.instance.password = arguments.password;
		return this;
	}

	public string function getDSName()
	{
		return variables.instance.DSName;
	}

	public string function getUsername()
	{
		return variables.instance.username;
	}

	public string function getPassword()
	{
		return variables.instance.password;
	}
}
</cfscript>