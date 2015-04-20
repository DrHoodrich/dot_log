component CategoryGateway
{
	variables.instance = {
		datasource = ''
	};

	public CategoryGateway function init(required dotlog.model.beans.datasource datasource)
	{
		variables.instance.datasource = arguments.datasource;
		return this;
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
}