component DAOTestAdapter extends="dotlog.model.dataAccess.userDAO"
{
	public boolean function createNewUser(required dotlog.model.beans.user user)
	{
		try {
			transaction action="begin" {
				saveUser(arguments.user);
				transactionRollBack();
				return true;
			}
		} catch (database expt) {
			rethrow;
		}
	}
}