component District
{
	variables.instance = {
		districtID = '',
		districtName = '',
		regionName = '',
		enabled = ''
	};

	public District function init(required string districtName,
								required string regionName,
								required numeric enabled,
								numeric districtID = -1)
	{
		variables.instance.districtID = arguments.districtID;
		variables.instance.districtName = arguments.districtName;
		variables.instance.regionName = arguments.regionName;
		variables.instance.enabled = arguments.enabled;
		return this;
	}

	public numeric function getDistrictID()
	{
		return variables.instance.districtID;
	}

	public string function getDistrictName()
	{
		return variables.instance.districtName;
	}

	public string function getRegionName()
	{
		return variables.instance.regionName;
	}

	public boolean function isEnabled() 
	{
		return variables.instance.enabled;
	}
}
