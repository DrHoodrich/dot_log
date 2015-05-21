component AirportService
{
	variables.instance = {
		airportDAO = '',
		airportGW = ''
	};

	public AirportService function init(required dotlog.model.dataAccess.DAO DAO,
										required dotlog.model.dataAccess.gateway GW)
	{
		variables.instance.airportDAO = arguments.DAO;
		variables.instance.airportGW = arguments.GW;
		return this;
	}

	public boolean function saveAirport(required dotlog.model.beans.airport airport)
	{
		return variables.instance.airportDAO.save(arguments.airport);
	} 

	public array function getSpokeAirports(required string airportCode)
	{
		var searchFilter = { hubCode = arguments.airportCode };
		return variables.instance.airportGW.filter(searchFilter);
	}

	public array function getHubAndSpokesAirports(required string airportCode)
	{
		var searchFilter = { hubCode = arguments.airportCode, spokes = '' };
		return variables.instance.airportGW.filter(searchFilter);
	}

	public array function getHubAirportsByDistrictID(required numeric districtID)
	{
		var searchFilter = { hubAirports = '', districtID = arguments.districtID };
		return variables.instance.airportGW.filter(searchFilter);
	}

	public dotlog.model.beans.airport function getAirportByAirportCode(required string airportCode)
	{
		var airport = '';
		var searchStruct = { airportCode = arguments.airportCode };
		var result = variables.instance.airportGW.filter(searchStruct);
		if ( arrayLen(result) ) {
			airport = result[1];
		}
		return airport;
	}
}