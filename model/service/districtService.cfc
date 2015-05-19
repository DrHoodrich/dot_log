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

	public dotlog.model.beans.District function getDistrictByID(required numeric districtID)
	{
		var district = '';
		var searchStruct = { districtID = arguments.districtID };
		var result = variables.instance.districtGW.filter(searchStruct);
		if ( arrayLen(result) ) {
			district = result[1];
		}
		return district;
	}

	public dotlog.model.beans.District function getDistrictByName(required string districtName)
	{
		var district = '';
		var searchStruct = { districtName = arguments.districtName };
		var result = variables.instance.districtGW.filter(searchStruct);
		if ( arrayLen(result) ) {
			district = result[1];
		} else {
			throw(message="No district by name " & arguments.districtName);
		}
		return district;
	}

	public array function getDistrictsByRegionID(required numeric regionID)
	{
		var searchFilter = { regionID = arguments.regionID };
		return variables.instance.districtGW.filter(searchFilter);
	}

	public array function getAllDistricts()
	{
		return variables.instance.districtGW.filter();
	}

	public array function getEnabledDistricts()
	{
		var searchFilter = { enabled = 1 };
		return variables.instance.districtGW.filter(searchFilter);
	}
}