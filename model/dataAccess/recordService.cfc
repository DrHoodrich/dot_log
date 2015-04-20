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

	public boolean function saveRecord(required dotlog.model.beans.record record)
	{
		return variables.instance.recordDAO.saveRecord(arguments.record);
	}

	public array function getRecordsByUsername(required string username)
	{
		return variables.instance.recordGW.getRecordsByUsername(arguments.username);
	}

	public array function getRecordsByAirportCode(required string airportCode)
	{
		return variables.instance.recordGW.getRecordsByAirportCode(arguments.airportCode);
	}

	public array function getRecordsAfterDate(required string date)
	{
		searchParam = {};
		searchParam.date = arguments.date;
		return variables.instance.recordGW.search(searchParam);
	}

	public record function getRecordByID(required numeric recordID)
	{
		return variables.instance.recordDAO.getRecordByID(arguments.recordID);
	}
}