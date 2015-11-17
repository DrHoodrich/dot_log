component RegionService extends = "dotlog.model.service.service"
{
	variables.instance = {
		RegionDAO = '',
		regionGW = ''
	};

	public RegionService function init(required dotlog.model.dataAccess.DAO DAO,
										required dotlog.model.dataAccess.gateway GW)
	{
		variables.instance.regionDAO = arguments.DAO;
		variables.instance.regionGW = arguments.GW;
		return this;
	}

	public boolean function saveRegion(required dotlog.model.beans.region region)
	{
		return variables.instance.regionDAO.save(arguments.region);
	} 

	public dotlog.model.beans.region function getRegionByName(required string regionName)
	{
		var searchFilter = { regionName = arguments.regionName};
		return fetchRegion(searchFilter);
	}

	public dotlog.model.beans.region function getRegionByID(required numeric regionID)
	{
		var searchFilter = { regionID = arguments.regionID };
		return fetchRegion(searchFilter);
	}

	public array function getAllRegions()
	{
		return variables.instance.regionGW.filter();
	}

	private dotlog.model.beans.region function fetchRegion(required struct searchFilter)
	{
		var region = '';
		var result = variables.instance.regionGW.filter(arguments.searchFilter);
		if ( arrayLen(result) ) {
			region = result[1];
		}
		return region;
	}
}