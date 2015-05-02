component recordGatewayTestAdapter extends="dotlog.model.dataAccess.recordGateway"
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