component extends = "taffy.core.resource" taffy_uri="/api/categories"
{
	DSName = "DOTlogDB";
	DSuser = " ";
	DSpasswd = " ";
	datasource = new dotlog.components.datasource(DSName, DSuser, DSpasswd);
	categoryDAO = new dotlog.components.categoryDAO(datasource);

	function get()
	{	
		enabledCategories = categoryDAO.getEnabledCategories();

		categoryStructs = [];

		for (var ii = 1; ii <= arrayLen(enabledCategories); ++ii) {
			categoryStruct = structNew(); // have to make a new struct every time so that the values aren't overwritten
			categoryStruct.name = enabledCategories[ii].getCategoryTitle();
			arrayAppend(categoryStructs, categoryStruct);
		}
				
		containingStructure = structNew();
		containingStructure.categories = categoryStructs;

		return representationOf(containingStructure).withStatus(200);
	}
}