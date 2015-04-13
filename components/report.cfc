component Report
{
	variables.instance = {
		report_id = '',
		username = '',
		airportCode = '',
		beginDate = '',
		endDate = ''
	};

	public Report function init(required string report_id,
								required string username,
								required string airportCode,
								required Class beginDate,
								required Class endDate
								)
	{
		variables.instance.report_id = arguments.report_id;
		variables.instance.username = arguments.username;
		variables.instance.airportCode = arguments.airportCode;
		variables.instance.beginDate = arguments.beginDate;
		variables.instance.endDate = arguments.endDate;
		return this;
	}

	public string function getUsername()
	{
		return variables.instance.username;
	}

	public string function getAirportCode()
	{
		return variables.instance.airportCode;
	}

	public Class function getBeginDate()
	{
		return variables.instance.beginDate;
	}

	public Class function getEndDate()
	{
		return variables.instance.endDate;
	}	
}