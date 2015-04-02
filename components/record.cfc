component Record {
        property name="recordText" type="string" default="" hint=""; 
        property name="username" type="string" default="" hint="";
        property name="faaCode" type="string" default="" hint="";
        property name="eventTime" type="string" default="" hint="";
        property name="recordTime" type="numeric" default="" hint="";
        property name="inWeeklyReport" type="numeric" default="" hint="";
        property name="categoryTitle" type="string" default="" hint="";

        public Record function init(required string recordText,
                                    required string username,
                                    required string faaCode,
                                    required string eventTime,
                                    required string recordTime,
                                    required numeric inWeeklyReport,
                                    required string categoryTitle)
        {                  
                variables.recordText = arguments.recordText;
                variables.username = arguments.username;
                variables.faaCode = arguments.faaCode;
                variables.eventTime = arguments.eventTime;
                variables.recordTime = arguments.recordTime;
                variables.inWeeklyReport = arguments.inWeeklyReport;
                variables.categoryTitle = arguments.categoryTitle;
                return this;
        }

        public string function getRecordText()
        {
                return variables.recordText;
        }

        public string function getUsername() 
        {
                return variables.username;
        }

        public string function getAirportFAACode() 
        {
                return variables.faaCode;
        }

        public string function getEventTime()
        {
                return variables.eventTime;
        }

        public string function getRecordTime() 
        {
                return variables.recordTime;
        }

        public boolean function isInWeeklyReport()
        {
                if (variables.inWeeklyReport) {
                        return True;
                } else {
                        return False;
                }
        }

        public string function getCategory() 
        {
                return variables.categoryTitle;
        }
}