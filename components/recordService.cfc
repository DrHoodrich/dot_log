component RecordService
{
	variables.instance = {
		recordDAO = '',
		recordGW = ''
	};

	public RecordService function init(required dotlog.components.datasource datasource)
	{
		variables.instance.recordDAO = new dotlog.components.recordDAO(arguments.datasource);
		variables.instance.recordGW = new dotlog.components.recordGateway(arguments.datasource);
		return this;
	}

	public boolean function saveRecord(record record)
	{
		return variables.instance.recordDAO.saveRecord(arguments.record);
	}

	public array function getRecordsByUsername(required string username)
	{
		return variables.instance.recordGW.getRecordsByUsername(arguments.username);
	}

	public array function getRecordsByAirportFAACode(required string faaCode)
	{
		return variables.instance.recordGW.getRecordsByAirportFAACode(arguments.faaCode);
	}


}