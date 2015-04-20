component Airport
{
	variables.instance = {
		airportCode = '', 
		parentAirportCode = '',
		airportName = '',
		enabled = ''
	};

	public Airport function init(required string airportCode,
								required string parentAirportCode,
								required string airportName,
								required numeric enabled)
	{
		variables.instance.airportCode = arguments.airportCode;
		variables.instance.parentAirportCode = arguments.parentAirportCode;
		variables.instance.airportName = arguments.airportName;
		variables.instance.enabled = arguments.enabled;
		return this;
	}

	public string function getAirportCode()
	{
		return variables.instance.airportCode;
	}

	public string function getParentAirportCode()
	{
		return variables.instance.parentAirportCode;
	}

	public string function getAirportName()
	{
		return variables.instance.airportName;
	}

	public boolean function isEnabled() 
	{
		return variables.instance.enabled;
	}
}
