component CategoryDAO extends = "dotlog.model.dataAccess.DAO"
{
	variables.queryHandler = '';

	public CategoryDAO function init(required dotlog.model.beans.datasource datasource)
	{
		variables.queryHandler = new dotlog.model.queryHandler(arguments.datasource);
		return this;
	}

	public boolean function save(required dotlog.model.beans.category category)
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
					& "DESCRIPTION = :description, ENABLED = :enabled, IN_WEEKLY_REPORT = :in_weekly_report, CATEGORY_TITLE = :category_title "
					& "WHERE CATEGORY_ID = :category_id";
		queryResult = variables.queryHandler.executeQuery(queryHandler, sqlString);
		return len(queryResult.getPrefix().recordCount);
	}

	private boolean function createCategory(required dotlog.model.beans.category category)
	{
		var queryHandler = getQueryHandler("createCategory", arguments.category);
		sqlString = "INSERT INTO DL_CATEGORIES "
					& "(CATEGORY_TITLE, DESCRIPTION, ENABLED, IN_WEEKLY_REPORT) "
					& "VALUES (:category_title, :description, :enabled, :in_weekly_report)";
		queryResult = variables.queryHandler.executeQuery(queryHandler, sqlString);
		return len(queryResult.getPrefix().rowID); //returns a number - need to fix?
	}

	private boolean function categoryExists(required dotlog.model.beans.category category)
	{
		var queryHandler = getQueryHandler("doesCategoryExist", arguments.category);
		sqlString = "SELECT category_title "
					& "FROM DL_CATEGORIES "
					& "WHERE category_id = :category_id";
		queryResult = variables.queryHandler.executeQuery(queryHandler, sqlString);
		return queryResult.getResult().recordCount;
	}

	private base function getQueryHandler(required string queryName, required dotlog.model.beans.category category)
	{
		var queryHandler = new query();

		queryHandler.setName(arguments.queryName);

		if ( category.getCategoryID() ) {
			queryHandler.addParam(name = "category_ID", value = arguments.category.getCategoryID(), cfsqltype = "cf_sql_number");	
		}
		queryHandler.addParam(name = "in_weekly_report", value = arguments.category.isInWeeklyReport(), cfsqltype = "cf_sql_number");
		queryHandler.addParam(name = "enabled", value = arguments.category.isEnabled(), cfsqltype = "cf_sql_number");
		queryHandler.addParam(name = "category_title", value = arguments.category.getCategoryTitle(), cfsqltype = "cf_sql_varchar");
		queryHandler.addParam(name = "description", value = arguments.category.getDescription(), cfsqltype = "cf_sql_varchar");

		return queryHandler;
	}
}