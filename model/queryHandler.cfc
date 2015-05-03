component QueryHandler
{
	variables.datasource = '';

	public QueryHandler function init(required dotlog.model.beans.datasource datasource)
	{
		variables.datasource = arguments.datasource;
		return this;
	}

	private base function setQueryDatasource(required base queryHandler)
	{
		var query = arguments.queryHandler;
		query.setDataSource(variables.datasource.getDSName());
		query.setUsername(variables.datasource.getUsername());
		query.setPassword(variables.datasource.getPassword());
		return query;
	}

	public result function executeQuery(required base queryHandler, required string sqlString)
	{
		var query = setQueryDatasource(arguments.queryHandler);
		var queryResult = query.execute(sql = arguments.sqlString);
		return queryResult;
	}
}