component Airport
{
    variables.instance = {
        airportCode = '', 
        hubCode = '',
        airportName = '',
        districtID = '',
        enabled = ''
    };

    public Airport function init(required string airportCode,
                                required string hubCode,
                                required string airportName,
                                required numeric districtID,
                                required numeric enabled)
    {
        variables.instance.airportCode = arguments.airportCode;
        variables.instance.hubCode = arguments.hubCode;
        variables.instance.airportName = arguments.airportName;
        variables.instance.districtID = arguments.districtID;
        variables.instance.enabled = arguments.enabled;
        return this;
    }

    public string function getAirportCode()
    {
        return variables.instance.airportCode;
    }

    public string function getHubCode()
    {
        return variables.instance.hubCode;
    }

    public string function getAirportName()
    {
        return variables.instance.airportName;
    }

    public numeric function getDistrictName()
    {
        return variables.instance.districtID;
    }

    public boolean function isEnabled() 
    {
        return variables.instance.enabled;
    }
}
