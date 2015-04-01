<cfscript>
component Category {
        result = new query();
        databaseConnector = new database();

        CategoryTitles = [];
         CategoryDescriptions = [];

        public Category function init()
        {
                result = databaseConnector.getCategories();

                for (var ii = 1; ii <= result.recordcount; ++ii) {
                        CategoryTitles[ii] = result["category_title"][ii];
                        CategoryDescriptions[ii] = result["description"][ii];
                }                              
                return this;
        }

        public array function getCategoryTitles() 
        {
                return CategoryTitles;
        }

         public array function getCategoryDescriptions() 
        {
                return CategoryDescriptions;
        }
}
</cfscript>