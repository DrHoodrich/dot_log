component RegionService
{
	variables.instance = {
		RegionDAO = '',
		regionGW = ''
	};

	public RegionService function init(required dotlog.model.beans.datasource datasource)
	{
		variables.instance.regionDAO = new dotlog.model.dataAccess.regionDAO(arguments.datasource);
		variables.instance.regionGW = new dotlog.model.dataAccess.regionGateway(arguments.datasource);
		return this;
	}

	public boolean function saveRegion(required dotlog.model.beans.region region)
	{
		return variables.instance.regionDAO.save(arguments.region);
	} 

	public dotlog.model.beans.region function getRegionByName(required string regionName)
	{
		var region = '';
		var searchFilter = { regionName = arguments.regionName};
		var result = variables.instance.regionGW.filter(searchFilter);
		if ( arrayLen(result) ) {
			region = result[1];
		}
		return region;
	}

	public dotlog.model.beans.region function getRegionByID(required numeric regionID)
	{
		var region = '';
		var searchFilter = { regionID = arguments.regionID };
		var result = variables.instance.regionGW.filter(searchFilter);
		if ( arrayLen(result) ) {
			region = result[1];
		}
		return region;
	}

	public array function getAllRegions()
	{
		return variables.instance.regionGW.filter();
	}
}