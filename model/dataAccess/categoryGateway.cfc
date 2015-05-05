component CategoryGateway
{
	variables.queryHandler = '';

	public CategoryGateway function init(required dotlog.model.beans.datasource datasource)
	{
		variables.queryHandler = new dotlog.model.queryHandler(arguments.datasource);
		return this;
	}

	public array function filter(struct searchFilter=structNew())
	{
		var queryService = new query();
		var sqlString = "SELECT category_title, description, enabled, in_weekly_report "
						& " FROM DL_CATEGORIES "
						& " WHERE 1 = 1 ";

		if ( structKeyExists(searchFilter, "enabled") ) {
			queryService.setName("fetchEnabledCategories");
			queryService.addParam(name = "enabled", value = 1, cfsqltype = "cf_sql_number");
			sqlString &= " AND enabled = :enabled";

		}
		var queryResult = queryHandler.executeQuery(queryService, sqlString);
		var result = queryResult.getResult();
		var categoryObjects = [];
		for (var ii = 1; ii <= result.RecordCount; ++ii) {
			 categoryObject = new dotlog.model.beans.category(categoryTitle = result["category_title"][ii],
																description = result["description"][ii],
																enabled = result["enabled"][ii],
																inWeeklyReport = result["in_weekly_report"][ii]);
			 arrayAppend(categoryObjects, categoryObject);
		}
		return categoryObjects;
	}
}