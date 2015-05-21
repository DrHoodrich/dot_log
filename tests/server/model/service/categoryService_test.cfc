component CategoryServiceTests extends = "mxunit.framework.TestCase"
{
    DSName = "DOTlogDB";
    DSuser = "";
    DSpasswd = "";

    categoryTitle = "Unit Test";
    categoryID = 428;
    description = "burny";
    enabled = 1;
    inWeeklyReport = 1;

	public void function setUp()
	{
        datasource = new dotlog.model.beans.datasource(DSName, DSuser, DSpasswd);
        categoryDAO = new dotlog.model.dataAccess.categoryDAO(datasource);
        categoryGW = new dotlog.model.dataAccess.categoryGateway(datasource);
        
        testCategoryDAO = new dotlog.tests.server.DAOTestAdapter(categoryDAO);
        testCategoryGW = new dotlog.tests.server.gatewayTestAdapter(categoryGW);
        testCategoryService = new dotlog.model.service.categoryService(testCategoryDAO, testCategoryGW);

		testCategory = new dotlog.model.beans.category(categoryTitle,
                                                        description,
                                                        enabled,
                                                        inWeeklyReport);
	}

    public void function saveCategory()
    {
        assertTrue(testCategoryDAO.save(testCategory) && testCategoryService.saveCategory(testCategory));
    }

    public void function getCategoryByTitle()
    {
        searchStruct = { categoryTitle = categoryTitle };

        resultFromGW = testCategoryGW.filter(searchStruct);
        resultFromService = testCategoryService.getCategoryByTitle(categoryID);

        assertEquals(resultFromGW[1], resultFromService);
    }

    public void function getEnabledCategories()
    {
        searchStruct = { enabled = enabled };

        resultFromGW = testCategoryGW.filter(searchStruct);
        resultFromService = testCategoryService.getEnabledCategories(categoryID);

        assertEquals(resultFromGW, resultFromService);
    }

    public void function getAllCategories()
    {
        resultFromGW = testCategoryGW.filter();
        resultFromService = testCategoryService.getAllCategories();

        assertEquals(resultFromGW, resultFromService);
    }

    public void function getCategoryByID()
    {
        searchStruct = { categoryID = categoryID };

        resultFromGW = testCategoryGW.filter(searchStruct);
        resultFromService = testCategoryService.getCategoryByID(categoryID);

        assertEquals(resultFromGW[1], resultFromService);
    }
}
