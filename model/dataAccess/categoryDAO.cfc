component CategoryDAO
{
	variables.instance = {
		datasource = '',
		queryHandler = ''
	};

	public CategoryDAO function init(required dotlog.model.beans.datasource datasource)
	{
		variables.instance.datasource = arguments.datasource;
		variables.instance.queryHandler = new dotlog.model.queryHandler();
		return this;
	}

	public dotlog.model.beans.category function getCategoryByTitle(required string categoryTitle)
	{
		var queryHandler = new query();

		queryHandler.setDataSource(variables.instance.datasource.getDSName());
		queryHandler.setUsername(variables.instance.datasource.getUsername());
		queryHandler.setPassword(variables.instance.datasource.getPassword());
		queryHandler.setName("fetchCategoryByTitle");
		queryHandler.addParam(name = "category_title", value = arguments.categoryTitle, cfsqltype = "cf_sql_varchar");
				
		sqlString = "SELECT category_title, description, enabled, in_weekly_report "
					& "FROM DL_CATEGORIES WHERE category_title = :category_title";

		queryResult = variables.instance.queryHandler.executeQuery(queryHandler, sqlString);
		result = queryResult.getResult();
		return new dotlog.model.beans.category(categoryTitle = result["category_title"][1],
												description = result["description"][1],
												enabled = result["enabled"][1],
												inWeeklyReport = result["in_weekly_report"][1]);
	}

	public boolean function saveCategory(required dotlog.model.beans.category category)
	{
		if ( categoryExists(arguments.category) ) {
			return updateCategory(arguments.category);
		} else { 
			return createCategory(arguments.category);
		} 
	}

	private boolean function updateCategory(required dotlog.model.beans.category category)
	{
		var queryHandler = getQueryHandler("updateCategory", arguments.category);

		sqlString = "UPDATE DL_CATEGORIES SET "
					& "DESCRIPTION = :description, ENABLED = :enabled, IN_WEEKLY_REPORT = :in_weekly_report "
					& "WHERE CATEGORY_TITLE = :category_title";
		queryResult = variables.instance.queryHandler.executeQuery(queryHandler, sqlString);
		return len(queryResult.getPrefix().recordCount);
	}

	private boolean function createCategory(required dotlog.model.beans.category category)
	{
		var queryHandler = getQueryHandler("createCategory", arguments.category);
		sqlString = "INSERT INTO DL_CATEGORIES "
					& "(CATEGORY_TITLE, DESCRIPTION, ENABLED, IN_WEEKLY_REPORT) "
					& "VALUES (:category_title, :description, :enabled, :in_weekly_report)";
		queryResult = variables.instance.queryHandler.executeQuery(queryHandler, sqlString);
		return len(queryResult.getPrefix().rowID); //returns a number - need to fix?
	}

	private boolean function categoryExists(required dotlog.model.beans.category category)
	{
		var queryHandler = getQueryHandler("doesCategoryExist", arguments.category);
		sqlString = "SELECT category_title "
					& "FROM DL_CATEGORIES "
					& "WHERE category_title = :category_title";
		queryResult = variables.instance.queryHandler.executeQuery(queryHandler, sqlString);
		return queryResult.getResult().recordCount;
	}

	private base function getQueryHandler(required string queryName, required dotlog.model.beans.category category)
	{
		var queryHandler = new query();

		queryHandler.setName(arguments.queryName);
		queryHandler.setDataSource(variables.instance.datasource.getDSName());
		queryHandler.setUsername(variables.instance.datasource.getUsername());
		queryHandler.setPassword(variables.instance.datasource.getPassword());

		queryHandler.addParam(name = "in_weekly_report", value = arguments.category.isInWeeklyReport(), cfsqltype = "cf_sql_number");
		queryHandler.addParam(name = "enabled", value = arguments.category.isEnabled(), cfsqltype = "cf_sql_number");
		queryHandler.addParam(name = "category_title", value = arguments.category.getCategoryTitle(), cfsqltype = "cf_sql_varchar");
		queryHandler.addParam(name = "description", value = arguments.category.getDescription(), cfsqltype = "cf_sql_varchar");

		return queryHandler;
	}
}