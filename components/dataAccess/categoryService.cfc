component CategoryService
{
	variables.instance = {
		categoryDAO = '',
		categoryGW = ''
	};
	
	public CategoryService function init(required dotlog.components.beans.datasource datasource)
	{
		variables.instance.categoryDAO = new dotlog.components.dataAccess.categoryDAO(arguments.datasource);
		variables.instance.categoryGW = new dotlog.components.dataAccess.categoryGateway(arguments.datasource);
		return this;
	}

	public array function getEnabledCategories()
	{
		return variables.instance.categoryGW.getEnabledCategories();
	}

	public array function getAllCategories()
	{
		return variables.instance.categoryGW.getAllCategories();
	}

	public category function getCategoryByTitle(required string categoryTitle)
	{
		return variables.instance.categoryDAO.getCategoryByTitle(arguments.categoryTitle);
	}

	public boolean function saveCategory(required dotlog.components.beans.category category)
	{
		return variables.instance.categoryDAO.saveCategory(arguments.category);
	}
}