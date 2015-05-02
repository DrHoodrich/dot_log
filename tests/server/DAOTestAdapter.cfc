component DAOTestAdapter
{
	variables.dataAccessObject = '';

	public DAOTestAdapter function init(required dotlog.model.dataAccess.DAO DAO)
	{
		variables.dataAccessObject = arguments.DAO;
		return this;
	}

	public boolean function save(required any object) //TODO: figure a way that only take objects for DB
	{
		try {
			transaction action="begin" {
				variables.dataAccessObject.save(object);
				transactionRollBack();
				return true;
			}
		} catch (database expt) {
			rethrow;
		}
	}

	public any function search(required struct searchParameters) //TODO: figure a way to return proper objects for DB
	{
		try {
			transaction action="begin" {
				result = variables.dataAccessObject.search(searchParameters);
				transactionRollBack();
				return result;
			}
		} catch (database expt) {
			rethrow;
		}
	}
}