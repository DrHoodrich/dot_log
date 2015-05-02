<cfset pageTitle = "Event Added">
<cfinclude template="/dotlog/includes/header.cfm">
<cfinclude template="/dotlog/includes/banner.cfm">
    <a id="main_content"></a>
<cfinclude template="/dotlog/includes/breadcrumb.cfm">
<cfinclude template="/dotlog/includes/nav.cfm">
    <div id="content">

<cfoutput><h2>#pageTitle#</h2></cfoutput>
<cfscript>

	if ( isNull(FORM.includeWeeklyReport) ) {
		reporting = 0;
	} else {
		reporting = 1;
	}

	reportedCategory = application.categoryService.getCategoryByTitle(FORM.categoryTitle);
	if (reportedCategory.isInWeeklyReport()) {
		reporting = 1;
	}

	record = new dotlog.model.beans.record(recordText = FORM.eventDescription,
										  username = FORM.userid,
										  airportCode = FORM.airportCode,
										  eventTime =  CREATEODBCDATETIME( FORM.eventDate & FORM.eventTime ),
										  recordTime =  CREATEODBCDATETIME( now() ),
										  inWeeklyReport = reporting,
										  categoryTitle = FORM.categoryTitle);
	application.recordService.save(record);	

	airports = application.airportService.getChildAirports(session.user.getAirportCode());
	categories = application.categoryService.getAllCategories();
</cfscript>
<cfinclude template="/dotlog/view/print_reports.cfm">
<cfscript>
	printAirportRecords(airports);
</cfscript>
<cfinclude template="/dotlog/includes/footer.cfm">