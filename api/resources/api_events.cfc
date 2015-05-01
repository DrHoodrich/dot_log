component extends = "taffy.core.resource" taffy_uri="/api/events"
{
	function put(required array EVENTS)
	{	
		if ( !arrayIsEmpty(events) ) {
			for (ii = 1; ii <= arrayLen(events); ++ii) {
				reported = 0;
				if (events[ii].in_weekly_report) {
					reported = 1;
				}
				record = new dotlog.model.beans.record( recordText = events[ii].event_text,
				                                    username = session.user.getUsername(),
				                                    airportCode = events[ii].FAA_CODE,
				                                    eventTime =  CREATEODBCDATETIME( events[ii].event_time ),
				                                    recordTime = CREATEODBCDATETIME( now() ),
				                                    inWeeklyReport = reported,
				                                     categoryTitle = events[ii].category_title);

				application.recordService.saveRecord(record);
			}
		} 

		return representationOf('').withStatus(200);
	}
}