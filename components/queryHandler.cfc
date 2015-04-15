component QueryHandler
{
	public QueryHandler function init()
	{
		return this;
	}

	public result function executeQuery(required base queryHandler, required string sqlString)
	{
		queryResult = '';
		transaction action="begin" {
			try {
				queryResult = arguments.queryHandler.execute(sql = arguments.sqlString);
			} catch (database exception) {
				writeDump(exception);
				transactionRollBack();
				// TODO - how to handle this exception
			}
			transactionCommit();
		}
		return queryResult;
	}
}