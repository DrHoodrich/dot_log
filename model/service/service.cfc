component Service
{
	variables.instance = {
		DAO = '',
		GW = ''
	};

	public Service function init(required dotlog.model.dataAccess.DAO DAO,
								required dotlog.model.dataAccess.GW GW)
	{
		variables.instance.DAO = new dotlog.model.dataAccess.DAO(arguments.datasource);
		variables.instance.GW = new dotlog.model.dataAccess.Gateway(arguments.datasource);
		return this;
	}
}