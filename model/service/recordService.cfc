component RecordService
{
	variables.recordDAO = '';
	variables.recordGW = '';

	public RecordService function init(required dotlog.model.beans.datasource datasource)
	{
		variables.recordDAO = new dotlog.model.dataAccess.recordDAO(arguments.datasource);
		variables.recordGW = new dotlog.model.dataAccess.recordGateway(arguments.datasource);
		return this;
	}

	public boolean function saveRecord(required dotlog.model.beans.record record)
	{
		return variables.recordDAO.save(arguments.record);
	}

	public array function getRecordsByAirportCode(required string airportCode)
	{
        var searchStruct = { airportCode = arguments.airportCode };
		return variables.recordGW.filter(searchStruct);
	}

	public array function getRecordsAfterDate(required string date)
	{
		searchParam = { date = arguments.date };
		return variables.recordGW.filter(searchParam);
	}

	public dotlog.model.beans.record function getRecordByID(required numeric recordID)
	{
		var record = '';
		var searchStruct = { recordID = arguments.recordID };
		var result = variables.recordGW.filter(searchStruct);
		if ( arrayLen(result) ) {
			record = result[1];
		}
		return record;
	}

	public array function search(required struct searchParam)
	{
		return variables.recordGW.filter(searchParam);
	}
}