component CategoryService extends = "dotlog.model.service.service"
{
	variables.instance = {
		categoryDAO = '',
		categoryGW = ''
	};
	
	public CategoryService function init(required dotlog.model.dataAccess.DAO DAO,
										required dotlog.model.dataAccess.gateway GW)
	{
		variables.instance.categoryDAO = arguments.DAO;
		variables.instance.categoryGW = arguments.GW;
		return this;
	}

	public array function getEnabledCategories()
	{
		var searchStruct = { enabled = 1 };
		return variables.instance.categoryGW.filter(searchStruct);
	}

	public array function getAllCategories()
	{
		return variables.instance.categoryGW.filter();
	}

	public dotlog.model.beans.category function getCategoryByTitle(required string categoryTitle)
	{
		var searchStruct = { categoryTitle = arguments.categoryTitle };
		return fetchCategory(searchStruct);
	}

	public dotlog.model.beans.category function getCategoryByID(required numeric categoryID)
	{
		var searchStruct = { categoryID = arguments.categoryID };
		return fetchCategory(searchStruct);
	}

	public boolean function saveCategory(required dotlog.model.beans.category category)
	{
		return variables.instance.categoryDAO.save(arguments.category);
	}

	public string function getCategoryTitleByID(required numeric categoryID)
	{
		var searchStruct = { categoryID = arguments.categoryID };
		return fetchCategory(searchStruct).getCategoryTitle();
	}

	private dotlog.model.beans.category function fetchCategory(required struct searchStruct)
	{
		var category = '';
		var result = variables.instance.categoryGW.filter(searchStruct);
		if ( arrayLen(result) ) {
			category = result[1];
		}
		return category;
	}
}