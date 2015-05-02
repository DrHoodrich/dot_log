component RecordService
{
	variables.instance = {
		recordDAO = '',
		recordGW = ''
	};

	public RecordService function init(required dotlog.model.beans.datasource datasource)
	{
		variables.instance.recordDAO = new dotlog.model.dataAccess.recordDAO(arguments.datasource);
		variables.instance.recordGW = new dotlog.model.dataAccess.recordGateway(arguments.datasource);
		return this;
	}

	public boolean function save(required dotlog.model.beans.record record)
	{
		return variables.instance.recordDAO.save(arguments.record);
	}

	public array function getRecordsByAirportCode(required string airportCode)
	{
        var searchStruct = { airportCode = arguments.airportCode };
		return variables.instance.recordGW.search(searchStruct);
	}

	public array function getRecordsAfterDate(required string date)
	{
		searchParam = { date = arguments.date };
		return variables.instance.recordGW.search(searchParam);
	}

	public dotlog.model.beans.record function getRecordByID(required numeric recordID)
	{
		var searchStruct = { id = arguments.recordID };
		return variables.instance.recordDAO.search(searchStruct);
	}

	public array function search(required struct searchParam)
	{
		return variables.instance.recordGW.search(searchParam);
	}
}