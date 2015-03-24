<cfscript>
component Category {
//        full_name = "";
        //hubAirportID = [];
        categoryStub = queryNew("category_id, name");
        possibleCategoryNames = [];

        public Category function init()
        {
                /*TODO - pull from the database: make sure enabled */
                queryAddRow(categoryStub);
                querySetCell(categoryStub, 'category_id', '1');
                querySetCell(categoryStub, 'name', 'Lighting');


                queryAddRow(categoryStub);
                querySetCell(categoryStub, 'category_id', '2');
                querySetCell(categoryStub, 'name', 'Fuel');

                return this;
        }

        public array function getCategoryNames() 
        {
                /*TODO - format to the database result*/
                for (var ii = 1; ii <= categoryStub.recordcount; ++ii) {
                        possibleCategoryNames[ii] = categoryStub["name"][ii];
                }
                return possibleCategoryNames;
        }
}
</cfscript>