component extends = "taffy.core.resource" taffy_uri="/api/categories"
{
	function get()
	{	

		airportChildren = [];		
		categories = [];

		enabledCategories = application.categoryService.getEnabledCategories();

		for ( i =1; i <= ArrayLen(enabledCategories); i ++)
		{
			categoryStruct = structNew();
			categoryStruct.category_title = enabledCategories[i].getCategoryTitle();
			arrayAppend(categories,categoryStruct);
		}
				
		containingStructure = structNew();
		containingStructure.categories = categories;

		return representationOf(containingStructure).withStatus(200);
	}
}