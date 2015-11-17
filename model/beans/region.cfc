component Region
{
	variables.instance = {
		regionName = '',
		regionID = ''
	};

	public Region function init(required string regionName, numeric regionID = -1)
	{
		variables.instance.regionName = arguments.regionName;
		variables.instance.regionID = arguments.regionID;
		return this;
	}

	public numeric function getRegionID()
	{
		return variables.instance.regionID;
	}

	public string function getRegionName()
	{
		return variables.instance.regionName;
	}
}
