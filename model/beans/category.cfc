component Category
{
	variables.instance = {
		categoryTitle = '',
		categoryDescription = '',
		enabled = '',
		inWeeklyReport = '',
		categoryID = ''
	};

	public Category function init(required string categoryTitle,
									required string description,
									required numeric enabled,
									required numeric inWeeklyReport,
									numeric categoryID = -1)
	{
		variables.instance.categoryTitle = arguments.categoryTitle;
		variables.instance.categoryDescription = arguments.description;
		variables.instance.enabled = arguments.enabled;
		variables.instance.inWeeklyReport = arguments.inWeeklyReport;
		variables.instance.categoryID = arguments.categoryID;
		return this;
	}

	public numeric function getCategoryID() 
	{
		return variables.instance.categoryID;
	}

	public string function getCategoryTitle() 
	{
		return variables.instance.categoryTitle;
	}

	public string function getDescription()
	{
		return variables.instance.categoryDescription;
	}

	public boolean function isEnabled() 
	{
		return variables.instance.enabled;
	}

	public boolean function isInWeeklyReport()
	{
		return variables.instance.inWeeklyReport;
	}
}