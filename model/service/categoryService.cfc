component CategoryService extends = "dotlog.model.dataAccess.DAO"
{
	variables.categoryDAO = '';
	variables.categoryGW = '';
	
	public CategoryService function init(required dotlog.model.beans.datasource datasource)
	{
		variables.categoryDAO = new dotlog.model.dataAccess.categoryDAO(arguments.datasource);
		variables.categoryGW = new dotlog.model.dataAccess.categoryGateway(arguments.datasource);
		return this;
	}

	public array function getEnabledCategories()
	{
		var searchStruct = { enabled = 1 };
		return variables.categoryGW.filter(searchStruct);
	}

	public array function getAllCategories()
	{
		return variables.categoryGW.filter();
	}

	public dotlog.model.beans.category function getCategoryByTitle(required string categoryTitle)
	{
		var searchStruct = { categoryTitle = arguments.categoryTitle };
		var category = '';
		var result = variables.categoryGW.filter(searchStruct);
		if ( arrayLen(result) ) {
			category = result[1];
		}
		return category;
	}

	public dotlog.model.beans.category function getCategoryByID(required numeric categoryID)
	{
		var searchStruct = { categoryID = arguments.categoryID };
		var category = '';
		var result = variables.categoryGW.filter(searchStruct);
		if ( arrayLen(result) ) {
			category = result[1];
		}
		return category;
	}

	public boolean function saveCategory(required dotlog.model.beans.category category)
	{
		return variables.categoryDAO.save(arguments.category);
	}
}