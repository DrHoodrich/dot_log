component QueryHandler
{
	public QueryHandler function init()
	{
		return this;
	}

	public result function executeQuery(required base queryHandler, required string sqlString)
	{
		queryResult = '';
		queryResult = arguments.queryHandler.execute(sql = arguments.sqlString);
		return queryResult;
	}
}
