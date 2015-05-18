component Gateway
{
	public DAO function init(required dotlog.model.beans.datasource datasource)
	{
		variables.instance.datasource = arguments.datasource;
		return this;
	}
}