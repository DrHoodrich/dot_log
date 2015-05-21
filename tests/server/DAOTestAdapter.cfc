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
}