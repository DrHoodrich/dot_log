component CategoryService
{
	variables.instance = {
		categoryDAO = '',
		categoryGW = ''
	};
	
	public CategoryService function init(required dotlog.model.beans.datasource datasource)
	{
		variables.instance.categoryDAO = new dotlog.model.dataAccess.categoryDAO(arguments.datasource);
		variables.instance.categoryGW = new dotlog.model.dataAccess.categoryGateway(arguments.datasource);
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

	public dotlog.model.beans.category function getCategoryByTitle(required string categoryTitle)
	{
		return variables.instance.categoryDAO.getCategoryByTitle(arguments.categoryTitle);
	}

	public boolean function saveCategory(required dotlog.model.beans.category category)
	{
		return variables.instance.categoryDAO.saveCategory(arguments.category);
	}
}