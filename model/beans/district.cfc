component District
{
    variables.instance = {
        districtID = '',
        districtName = '',
        regionID = '',
        enabled = ''
    };

    public District function init(required string districtName,
                                required numeric regionID,
                                required numeric enabled,
                                numeric districtID = -1)
    {
        variables.instance.districtID = arguments.districtID;
        variables.instance.districtName = arguments.districtName;
        variables.instance.regionID = arguments.regionID;
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

    public string function getRegionID()
    {
        return variables.instance.regionID;
    }

    public boolean function isEnabled() 
    {
        return variables.instance.enabled;
    }
}
