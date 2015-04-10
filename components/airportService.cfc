component AirportService
{
	variables.instance = {
		airportDAO = '',
		airportGW = ''
	};

	public AirportService function init(required datasource datasource)
	{
		variables.instance.airportDAO = new dotlog.components.airportDAO(arguments.datasource);
		variables.instance.airportGW = new dotlog.components.airportGateway(arguments.datasource);
		return this;
	}

	public boolean function saveAirport(required airport airport)
	{
		return variables.instance.airportDAO.saveAirport(arguments.airport);
	} 

	public array function getChildAirports(required string faaCode)
	{
		return variables.instance.airportGW.getChildAirports(arguments.faaCode);	
	}

	public airport function getAirportByFAACode(required string faaCode)
	{
		return variables.instance.airportDAO.getChildAirport(arguments.faaCode);		
	}
}