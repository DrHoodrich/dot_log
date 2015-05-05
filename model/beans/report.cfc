component Report
{
	variables.instance = {
		reportID = '',
		username = '',
		airportCode = '',
		beginDate = '',
		endDate = ''
	};

	public Report function init(required string username,
								required string airportCode,
								required string beginDate,
								required string endDate,
								required numeric reportID = -1)
	{
		variables.instance.reportID = arguments.reportID;
		variables.instance.username = arguments.username;
		variables.instance.airportCode = arguments.airportCode;
		variables.instance.beginDate = arguments.beginDate;
		variables.instance.endDate = arguments.endDate;
		return this;
	}

	public numeric function getReportID()
	{
		return variables.instance.reportID;
	}

	public string function getUsername()
	{
		return variables.instance.username;
	}

	public string function getAirportCode()
	{
		return variables.instance.airportCode;
	}

	public string function getBeginDate()
	{
		return variables.instance.beginDate;
	}

	public string function getEndDate()
	{
		return variables.instance.endDate;
	}	
}