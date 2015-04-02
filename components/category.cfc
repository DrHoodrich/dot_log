component Category
{
        property name="categoryTitle" type="string" default="" hint=""; 
        property name="description" type="string" default="" hint="";
        property name="enabled" type="numeric" default="" hint="";
        property name="inWeeklyReport" type="numeric" default="" hint="";

        public Category function init(required string categoryTitle,
                                        required string description,
                                        required numeric enabled,
                                        required numeric inWeeklyReport)
        {
               variables.categoryTitle = arguments.categoryTitle;
               variables.description = arguments.description;
               variables.enabled = arguments.enabled;
               variables.inWeeklyReport = arguments.inWeeklyReport;
               return this;
        }

        public string function getCategoryTitle() 
        {
                return variables.categoryTitle;
        }

        public string function getDescription()
        {
                return variables.description;
        }

        public boolean function isEnabled() 
        {
                return variables.enabled;
        }

        public boolean function isInWeeklyReport()
        {
                return inWeeklyReport;
        }
}