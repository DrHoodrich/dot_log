component DAO
{
	variables.instance = {
		datasource = '',
		queryHandler = ''
	};

	public DAO function init(required dotlog.model.beans.datasource datasource)
	{
		variables.instance.datasource = arguments.datasource;
		variables.instance.queryHandler = new dotlog.model.queryHandler();
		return this;
	}
}