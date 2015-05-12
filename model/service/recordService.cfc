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

	public boolean function save(required dotlog.model.beans.record record)
	{
		return variables.recordDAO.save(arguments.record);
	}

	public array function getRecordsByAirportCode(required string airportCode)
	{
        var searchStruct = { airportCode = arguments.airportCode };
		return variables.recordGW.search(searchStruct);
	}

	public array function getRecordsAfterDate(required string date)
	{
		searchParam = { date = arguments.date };
		return variables.recordGW.search(searchParam);
	}

	public dotlog.model.beans.record function getRecordByID(required numeric recordID)
	{
		var searchStruct = { id = arguments.recordID };
		return variables.recordDAO.search(searchStruct);
	}

	public array function search(required struct searchParam)
	{
		return variables.recordGW.search(searchParam);
	}
}