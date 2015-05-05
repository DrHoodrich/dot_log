component AirportService
{
	variables.instance = {
		airportDAO = '',
		airportGW = ''
	};

	public AirportService function init(required dotlog.model.beans.datasource datasource)
	{
		variables.instance.airportDAO = new dotlog.model.dataAccess.airportDAO(arguments.datasource);
		variables.instance.airportGW = new dotlog.model.dataAccess.airportGateway(arguments.datasource);
		return this;
	}

	public boolean function saveAirport(required dotlog.model.beans.airport airport)
	{
		return variables.instance.airportDAO.save(arguments.airport);
	} 

	public array function getChildAirports(required string airportCode)
	{
		return variables.instance.airportGW.getChildAirports(arguments.airportCode);	
	}

	public dotlog.model.beans.airport function getAirportByAirportCode(required string airportCode)
	{
		var searchFilter = { airportCode = arguments.airportCode };
		return variables.instance.airportDAO.search(searchFilter);		
	}
}