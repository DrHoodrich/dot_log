component CategoryGateway extends = "dotlog.model.dataAccess.gateway"
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
		var sqlString = "SELECT category_id, category_title, description, enabled, in_weekly_report "
						& " FROM DL_CATEGORIES "
						& " WHERE 1 = 1 ";

		if ( !structIsEmpty(searchFilter) ) {
			queryService.setName("filterCategories");
			if ( structKeyExists(searchFilter, "categoryID") ) {
				queryService.addParam(name = "categoryID", value = arguments.searchFilter.categoryID, cfsqltype = "cf_sql_number");
				sqlString &= " AND category_id = :categoryID";
			}
			if ( structKeyExists(searchFilter, "category_title") ) {
				query.addParam(name = "category_title", value = arguments.searchFilter.category_title, cfsqltype = "cf_sql_varchar");	
				sqlString &= " AND category_title = :category_title";
			}
			if ( structKeyExists(searchFilter, "description") ) {
				queryService.addParam(name = "description", value = "%"&arguments.searchFilter.description&"%", cfsqltype = "cf_sql_varchar");	
				sqlString &= " AND LOWER(description) LIKE LOWER(:description)";
			}
			if ( structKeyExists(searchFilter, "enabled") ) {
				queryService.addParam(name = "enabled", value = 1, cfsqltype = "cf_sql_number");
				sqlString &= " AND enabled = :enabled";
			}
		} else {
			queryService.setName("getAllCategories");
		}

		var queryResult = queryHandler.executeQuery(queryService, sqlString);
		var result = queryResult.getResult();
		var categorys = [];
		for (var ii = 1; ii <= result.RecordCount; ++ii) {
			 category = new dotlog.model.beans.category(categoryTitle = result["category_title"][1],
															description = result["description"][1],
															enabled = result["enabled"][1],
															inWeeklyReport = result["in_weekly_report"][1],
															categoryID = result["category_id"][1]);
			 arrayAppend(categorys, category);
		}
		return categorys;
	}
}