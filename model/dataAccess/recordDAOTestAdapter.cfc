component DAOTestAdapter extends="dotlog.model.dataAccess.recordDAO"
{
	public boolean function createNewRecord(required dotlog.model.beans.record record)
	{
		try {
			transaction action="begin" {
				createRecord(record);
				transactionRollBack();
				return true;
			}
		} catch (database expt) {
			rethrow;
		}
	}
}