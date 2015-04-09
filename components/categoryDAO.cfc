component CategoryDAO
{
	variables.instance = {
		datasource = ''
	};

	public CategoryDAO function init(required dotlog.components.datasource datasource)
	{
		variables.instance.datasource = arguments.datasource;
		return this;
	}

	public category function getCategoryByTitle(required string categoryTitle)
	{
		var queryService = new query();
		queryService.addParam(name = "category_title", value = arguments.categoryTitle, cfsqltype = "cf_sql_varchar");
		DSname = variables.instance.datasource.getDSName();
		DSusername = variables.instance.datasource.getUsername();
		DSpassword = variables.instance.datasource.getPassword();

		

		queryService.setName("fetchCategory");
		queryService.setDataSource(variables.instance.datasource.getDSName());
		queryService.setUsername(DSusername);
		queryService.setPassword(DSpassword);
		
 		transaction action="begin" {
			try {
				queryResult = queryService.execute(sql = "SELECT category_title, description, enabled, in_weekly_report
					FROM DL_CATEGORIES WHERE category_title = :category_title");
			} catch (database excpt) {
				transactionRollback();
				rethrow();
				return false;
			}
		}
		result = queryResult.getResult();
		return new Category(categoryTitle = result["category_title"][1],
							description = result["description"][1],
							enabled = result["enabled"][1],
							inWeeklyReport = result["in_weekly_report"][1]);
	}

	public array function getEnabledCategories()
	{
		var categoryObjects = [];

		DSname = variables.instance.datasource.getDSName();
		DSusername = variables.instance.datasource.getUsername();
		DSpassword = variables.instance.datasource.getPassword();

		var queryService = new query();

		queryService.setName("fetchEnabledCategories");
		queryService.setDataSource(variables.instance.datasource.getDSName());
		queryService.setUsername(DSusername);
		queryService.setPassword(DSpassword);

		queryService.addParam(name = "enabled", value = 1, cfsqltype = "cf_sql_number");
		queryResult = queryService.execute(sql = "SELECT category_title, description, enabled, in_weekly_report
			FROM DL_CATEGORIES WHERE enabled = :enabled");
		result = queryResult.getResult();

		for (var ii = 1; ii <= result.RecordCount; ++ii) {
			 categoryObject = new Category(categoryTitle = result["category_title"][ii],
											description = result["description"][ii],
											enabled = result["enabled"][ii],
											inWeeklyReport = result["in_weekly_report"][ii]);
			 arrayAppend(categoryObjects, categoryObject);
		}
		return categoryObjects;
	}

	public array function getAllCategories()
	{
		var categoryObjects = [];

		DSname = variables.instance.datasource.getDSName();
		DSusername = variables.instance.datasource.getUsername();
		DSpassword = variables.instance.datasource.getPassword();

		var queryService = new query();

		queryService.setName("fetchEnabledCategories");
		queryService.setDataSource(variables.instance.datasource.getDSName());
		queryService.setUsername(DSusername);
		queryService.setPassword(DSpassword);

		queryResult = queryService.execute(sql = "SELECT category_title, description, enabled, in_weekly_report
			FROM DL_CATEGORIES");
		result = queryResult.getResult();

		for (var ii = 1; ii <= result.RecordCount; ++ii) {
			 categoryObject = new Category(categoryTitle = result["category_title"][ii],
											description = result["description"][ii],
											enabled = result["enabled"][ii],
											inWeeklyReport = result["in_weekly_report"][ii]);
			 arrayAppend(categoryObjects, categoryObject);
		}
		return categoryObjects;
	}

	public boolean function saveCategory(required category category)
	{
		if (categoryExists(arguments.category)) {
			return updateCategory(arguments.category);
		} else { 
			return createCategory(arguments.category);	
		} 
	}

	private boolean function updateCategory(required category category)
	{
		var queryHandler = getQueryHandler("updateCategory", arguments.category);
		transaction action="begin" {
			try {
				queryResult = queryHandler.execute(sql = "UPDATE DL_CATEGORIES SET 
					DESCRIPTION = :description, ENABLED = :enabled, IN_WEEKLY_REPORT = :in_weekly_report 
						WHERE CATEGORY_TITLE = :category_title");
			} catch (database excpt) {
				transactionRollback();
				rethrow();
				return false;
			}
		}
		return true;
	}

	private boolean function createCategory(required category category)
	{
		var queryHandler = getQueryHandler("createCategory", arguments.category);
		
 		transaction action="begin" {
			try {
				queryResult = queryHandler.execute(sql = "INSERT INTO DL_CATEGORIES 
					(CATEGORY_TITLE, DESCRIPTION, ENABLED, IN_WEEKLY_REPORT) 
					VALUES (:category_title, :description, :enabled, :in_weekly_report)");
			} catch (database excpt) {
				transactionRollback();
				rethrow();
				return false;
			}
		}
		return true;
	}

	private boolean function categoryExists(required category category)
	{
		var queryHandler = getQueryHandler("doesCategoryExist", arguments.category);
		queryResult = queryHandler.execute(sql = "SELECT category_title FROM DL_CATEGORIES WHERE category_title = :category_title");
		return queryResult.getResult().recordCount;
	}

	private base function getQueryHandler(required string queryName, required category category)
	{
		var queryService = new query();

		queryService.setName(arguments.queryName);
		queryService.setDataSource(variables.instance.datasource.getDSName());
		queryService.setUsername(variables.instance.datasource.getUsername());
		queryService.setPassword(variables.instance.datasource.getPassword());

		queryService.addParam(name = "in_weekly_report", value = arguments.category.isInWeeklyReport(), cfsqltype = "cf_sql_number");
		queryService.addParam(name = "enabled", value = arguments.category.isEnabled(), cfsqltype = "cf_sql_number");
		queryService.addParam(name = "category_title", value = arguments.category.getCategoryTitle(), cfsqltype = "cf_sql_varchar");
		queryService.addParam(name = "description", value = arguments.category.getDescription(), cfsqltype = "cf_sql_varchar");

		return queryService;
	}
}