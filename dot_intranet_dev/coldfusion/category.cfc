<cfscript>
component Category {
//        variables.full_name = "";
        //variables.hubAirportID = [];
        variables.categoryStub = queryNew("category_id, name");
        variables.possibleCategoryNames = [];

        public Category function init()
        {
                /*TODO - pull from the database: make sure enabled */
                queryAddRow(variables.categoryStub);
                querySetCell(variables.categoryStub, 'category_id', '1');
                querySetCell(variables.categoryStub, 'name', 'Lighting');


                queryAddRow(variables.categoryStub);
                querySetCell(variables.categoryStub, 'category_id', '2');
                querySetCell(variables.categoryStub, 'name', 'Fuel');

                return this;
        }

        public array function getCategoryNames() 
        {
                /*TODO - format to the database result*/
                for (ii = 1; ii <= variables.categoryStub.recordcount; ++ii) {
                        variables.possibleCategoryNames[ii] = variables.categoryStub["name"][ii];
                }
                return variables.possibleCategoryNames;
        }
}
</cfscript>