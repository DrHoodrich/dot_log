<cfset pageTitle = "DOTLog Record Creation">
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

	record = new dotlog.components.record(recordText = FORM.eventDescription,
										  username = FORM.userid,
										  airportCode = FORM.airportCode,
										  eventTime =  CREATEODBCDATETIME( now() ),
										  recordTime =  CREATEODBCDATETIME( now() ),
										  inWeeklyReport = reporting,
										  categoryTitle = FORM.categoryTitle);
	application.recordService.saveRecord(record);	

	airports = application.airportService.getChildAirports(session.user.getAirportCode());
	categories = application.categoryService.getAllCategories();

	writeOutput('<table width="783" height="180" border="1">');
		for (ii = 1; ii <= arrayLen(airports); ++ii) {
			records = application.recordService.getRecordsByAirportCode(airports[ii].getAirportCode());

			for (jj = 1; jj <= arrayLen(records); ++jj) {
				writeOutput('<tr> <td width="117" height="102" align="left" valign="top"> #records[jj].getEventTime()# <br>');
				writeOutput(' Reporter: #records[jj].getUsername()# <br>Airport: #records[jj].getAirportCode()# <br> Category: #records[jj].getCategory()# <br>');
				writeOutput('<td width="560" align="left" valign="top">#records[jj].getRecordText()#</td>');
				writeOutput('<td width="92" align="right" valign="top"><form name="form1" method="post" action="">');
				writeOutput('<input type="checkbox" name="event_1_important" id="event_1_important">');
				writeOutput('<label for="event_#jj#_important">Important</label>');
				writeOutput('<label for="entry_1_important"></label></form></td>');
	  		}
		}
	writeOutput('</table>');
</cfscript>
<cfinclude template="/dotlog/includes/footer.cfm">