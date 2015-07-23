<cfset pageTitle = "Event Added">
<cfinclude template="/dotlog/view/header.cfm">

<cfoutput><h2>pageTitle</h2></cfoutput>
<cfscript>

	if ( isNull(FORM.includeWeeklyReport) ) {
		reporting = 0;
	} else {
		reporting = 1;
	}

	reportedCategory = application.categoryService.getCategoryByID(FORM.categoryID);
	if (reportedCategory.isInWeeklyReport()) {
		reporting = 1;
	}

	record = new dotlog.model.beans.record(recordText = FORM.eventDescription,
										  username = FORM.userid,
										  airportCode = FORM.airportCode,
										  eventTime =  CREATEODBCDATETIME( FORM.eventDate & FORM.eventTime ),
										  recordTime =  CREATEODBCDATETIME( now() ),
										  inWeeklyReport = reporting,
										  categoryID = FORM.categoryID);
	application.recordService.saveRecord(record);	

	airports = application.airportService.getHubAndSpokesAirports(session.user.getAirportCode());
</cfscript>
<cfinclude template="/dotlog/view/print_reports.cfm">
<cfscript>
	printAirportRecords(airports);
</cfscript>
<cfinclude template="/dotlog/includes/footer.cfm">