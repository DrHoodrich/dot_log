component DistrictService extends = "dotlog.model.service.service"
{
	variables.instance = {
		districtDAO = '',
		districtGW = ''
	};

	public DistrictService function init(required dotlog.model.dataAccess.DAO DAO,
										required dotlog.model.dataAccess.gateway GW)
	{
		variables.instance.districtDAO = arguments.DAO;
		variables.instance.districtGW = arguments.GW;
		return this;
	}

	public boolean function saveDistrict(required dotlog.model.beans.district district)
	{
		return variables.instance.districtDAO.save(arguments.district);
	} 

	public dotlog.model.beans.District function getDistrictByID(required numeric districtID)
	{
		var searchFilter = { districtID = arguments.districtID };
		return fetchDistrict(searchFilter);
	}

	public dotlog.model.beans.District function getDistrictByName(required string districtName)
	{
		var searchFilter = { districtName = arguments.districtName };
		return fetchDistrict(searchFilter);
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

	private dotlog.model.beans.District function fetchDistrict(required struct searchFilter)
	{
		var result = variables.instance.districtGW.filter(arguments.searchFilter);
		if ( arrayLen(result) ) {
			district = result[1];
		} else {
			throw(message="No district by name " & arguments.districtName);
		}
		return district;
	}
}