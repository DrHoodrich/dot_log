component UserDAOTests extends = "mxunit.framework.TestCase"
{
	DSName = "DOTlogDB";
	DSuser = " ";
	DSpasswd = " ";

	categoryTitle = "Fire";
    description = "burny";
    enabled = 1;
    inWeeklyReport = 1;

	public void function setUp()
	{
		datasource = new dotlog.model.beans.datasource(DSName, DSuser, DSpasswd);
		categoryDAO = new dotlog.model.dataAccess.categoryDAO(datasource);
		testCategoryDAO = new dotlog.tests.server.DAOTestAdapter(categoryDAO);
		testCategory = new dotlog.model.beans.category(categoryTitle,
                                                        description,
                                                        enabled,
                                                        inWeeklyReport);
	}

	public void function categoryDAOConstruction()
	{		
		assertSame(categoryDAO, categoryDAO.init(datasource));
	}

	public void function categoryDAOCreateCategory()
	{
		assertTrue(testCategoryDAO.save(testCategory));
	}

	public void function updateCategory()
	{
	    descriptionChanged = "It's hot...";
	    testCategory = new dotlog.model.beans.category(categoryTitle,
                                                        description,
                                                        enabled,
                                                        inWeeklyReport);
	    assertTrue(testCategoryDAO.save(testCategory));
	}
}