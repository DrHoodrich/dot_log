component Record
{
        variables.instance = {
            recordID = '',
            recordText = '',
            username = '',
            airportCode = '',
            eventTime = '',
            recordTime = '',
            inWeeklyReport = '',
            categoryTitle = ''
        };
        

        public Record function init(required string recordText,
                                    required string username,
                                    required string airportCode,
                                    required string eventTime,
                                    required string recordTime,
                                    required numeric inWeeklyReport,
                                    required string categoryTitle,
                                    numeric recordID = -1)
        {
                variables.instance.recordID = recordID;
                variables.instance.recordText = arguments.recordText;
                variables.instance.username = arguments.username;
                variables.instance.airportCode = arguments.airportCode;
                variables.instance.eventTime = arguments.eventTime;
                variables.instance.recordTime = arguments.recordTime;
                variables.instance.inWeeklyReport = arguments.inWeeklyReport;
                variables.instance.categoryTitle = arguments.categoryTitle;
                return this;
        }

        public numeric function getRecordID()
        {
            return variables.instance.recordID;
        }

        public string function getRecordText()
        {
                return variables.instance.recordText;
        }

        public string function getUsername() 
        {
                return variables.instance.username;
        }

        public string function getAirportCode() 
        {
                return variables.instance.airportCode;
        }

        public string function getEventTime()
        {
                return variables.instance.eventTime;
        }

        public string function getRecordTime() 
        {
                return variables.instance.recordTime;
        }

        public boolean function isInWeeklyReport()
        {
                return (variables.instance.inWeeklyReport);
        }

        public string function getCategory() 
        {
                return variables.instance.categoryTitle;
        }
}
