component RecordService extends = "dotlog.model.service.service"
{
	variables.instance = {
		recordDAO = '',
		recordGW = ''
	};

	public RecordService function init(required dotlog.model.dataAccess.DAO DAO,
										required dotlog.model.dataAccess.gateway GW)
	{
		variables.instance.recordDAO = arguments.DAO;
		variables.instance.recordGW = arguments.GW;
		return this;
	}

	public boolean function saveRecord(required dotlog.model.beans.record record)
	{
		return variables.instance.recordDAO.save(arguments.record);
	}

	public array function getRecordsByAirportCode(required string airportCode)
	{
        var searchStruct = { airportCode = arguments.airportCode };
		return variables.instance.recordGW.filter(searchStruct);
	}

	public array function getRecordsAfterDate(required string date)
	{
		searchParam = { date = arguments.date };
		return variables.instance.recordGW.filter(searchParam);
	}

	public dotlog.model.beans.record function getRecordByID(required numeric recordID)
	{
		var record = '';
		var searchStruct = { recordID = arguments.recordID };
		var result = variables.instance.recordGW.filter(searchStruct);
		if ( arrayLen(result) ) {
			record = result[1];
		}
		return record;
	}

	public array function search(required struct searchParam)
	{
		return variables.instance.recordGW.filter(searchParam);
	}
}