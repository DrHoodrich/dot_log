<cfscript>
component Category {
        result = new query();
        databaseConnector = new database();

        arrayCategoryNames = [];
        arrayCategoryID = [];

        public Category function init()
        {
                result = databaseConnector.getCategories();

                for (var ii = 1; ii <= result.recordcount; ++ii) {
                        arrayCategoryNames[ii] = result["name"][ii];
                        arrayCategoryID[ii] = result["category_id"][ii];
                }                              
                return this;
        }

        public array function getCategoryNames() 
        {
                return arrayCategoryNames;
        }

        public array function getCategoryIDs()
        {
                return arrayCategoryID;
        }
}
</cfscript>