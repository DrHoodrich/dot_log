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
		return variables.categoryGW.getEnabledCategories();
	}

	public array function getAllCategories()
	{
		return variables.categoryGW.getAllCategories();
	}

	public dotlog.model.beans.category function getCategoryByTitle(required string categoryTitle)
	{
		var searchParam = { category_title = arguments.categoryTitle };
		return variables.categoryDAO.search(searchParam);
	}

	public boolean function saveCategory(required dotlog.model.beans.category category)
	{
		return variables.categoryDAO.save(arguments.category);
	}
}