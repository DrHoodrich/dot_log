component extends = "taffy.core.resource" taffy_uri="/api/categories"
{
	DSName = "DOTlogDB";
	DSuser = " ";
	DSpasswd = " ";
	datasource = new dotlog.components.datasource(DSName, DSuser, DSpasswd);
	categoryDAO = new dotlog.components.categoryDAO(datasource);

	function get()
	{	
		//enabledCategories = categoryDAO.getEnabledCategories();

		categoryStructs = [];

		
		categoryStruct.category_title = "Fire";
		arrayAppend(categoryStructs, categoryStruct);

		categoryStruct1.category_title = "Lighting";
		arrayAppend(categoryStructs, categoryStruct1);
		
				
		containingStructure = structNew();
		containingStructure.categories = categoryStructs;

		return representationOf(containingStructure).withStatus(200);
	}
}