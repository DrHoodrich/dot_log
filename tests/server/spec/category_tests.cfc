component userTest extends = "mxunit.framework.TestCase" {
	categoryTitle = "Fire";
    description = "burny";
    enabled = 1;
    inWeeklyReport = 1;

	public void function setUp()
	{
		testCategory = new dotlog.components.category(categoryTitle,
                                                    description,
                                                    enabled,
                                                    inWeeklyReport);
	}

	public void function getCategoryTitle()
	{
		expected = categoryTitle;
		actual = testCategory.getCategoryTitle();
		assertEquals(expected, actual);
	}

    public void function getCategoryDescription() 
    {
    	expected = description;
    	actual = testCategory.getDescription();
    	assertEquals(expected, actual);
    }

    public void function categoryEnabled()
    {
		assert( testCategory.isEnabled() );
    }

    public void function isInWeeklyReport()
    {
    	assert( testCategory.isInWeeklyReport() );
    }
}