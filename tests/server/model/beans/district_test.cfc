component DistrictTest extends = "mxunit.framework.TestCase"
{
	districtID = "1";
	districtName = "testDistrict";
	regionID = 1;
	enabled = 1;

	public void function setUp()
	{
		testDistrict = new dotlog.model.beans.district(districtName,
													regionID,
													enabled,
													districtID);
	}

	public void function getDistrictID()
	{
		expected = districtID;
		actual = testDistrict.getDistrictID();
		assertEquals(expected, actual);
	}

    public void function getDistrictName()
    {
        expected = districtName;
        actual = testDistrict.getDistrictName();
        assertEquals(expected, actual);
    }

	public void function getRegionID() 
	{
		expected = regionID;
		actual = testDistrict.getRegionID();
		assertEquals(expected, actual);
	}

	public void function isEnabled() 
	{
		expected = enabled;
		actual = testDistrict.isEnabled();
		assertEquals(expected, actual);
	}
}