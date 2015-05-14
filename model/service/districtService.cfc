component DistrictService
{
	variables.instance = {
		districtDAO = '',
		districtGW = ''
	};

	public DistrictService function init(required dotlog.model.beans.datasource datasource)
	{
		variables.instance.districtDAO = new dotlog.model.dataAccess.districtDAO(arguments.datasource);
		variables.instance.districtGW = new dotlog.model.dataAccess.districtGateway(arguments.datasource);
		return this;
	}

	public boolean function saveDistrict(required dotlog.model.beans.district district)
	{
		return variables.instance.districtDAO.save(arguments.district);
	} 

	public array function getDistrictByName(required string districtName)
	{
		var searchFilter = { districtName = arguments.districtName};
		return variables.instance.districtGW.filter(searchFilter);
	}

	public array function getDistrictsByRegion(required string regionName)
	{
		var searchFilter = { regionName = arguments.regionName };
		return variables.instance.districtGW.search(searchFilter);
	}
}