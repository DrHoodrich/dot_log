<cfset pageTitle = "DOTLog Record Creation">
<cfinclude template="../includes/header.cfm">
<cfinclude template="../includes/banner.cfm">
    <a id="main_content"></a>
<cfinclude template="../includes/breadcrumb.cfm">
<cfinclude template="../includes/nav.cfm">
    <div id="content">

<cfoutput><h2>#pageTitle#</h2></cfoutput>
<cfscript>
	writeDump(FORM);
	if ( isNull(FORM.includeWeeklyReport) ) {
		reporting = 0;
	} else {
		reporting = 1;
	}
	record = new dotlog.components.record(recordText = FORM.eventDescription,
										  username = FORM.userid,
										  faaCode = FORM.airportCode,
										  eventTime =  CREATEODBCDATETIME( now() ),
										  recordTime =  CREATEODBCDATETIME( now() ),
										  inWeeklyReport = reporting,
										  categoryTitle = FORM.categoryTitle);
	application.recordService.saveRecord(record);	

	user = application.userService.getUserByUsername("us");
	airports = application.airportDAO.getChildAirports(user.getAirportFAACode());
	categories = application.categoryDAO.getAllCategories();

	writeOutput('<table width="783" height="180" border="1">');
		for (ii = 1; ii <= arrayLen(airports); ++ii) {
			records = application.recordService.getRecordsByAirportFAACode(airports[ii].getFAACode());

			for (jj = 1; jj <= arrayLen(records); ++jj) {
				writeOutput('<tr> <td width="117" height="102" align="left" valign="top"> #records[jj].getEventTime()# <br>');
				writeOutput(' Reporter: #records[jj].getUsername()# <br>Airport: #records[jj].getAirportFAACode()# <br> Category: #records[jj].getCategory()# <br>');
				writeOutput('<td width="560" align="left" valign="top">#records[jj].getRecordText()#</td>');
				writeOutput('<td width="92" align="right" valign="top"><form name="form1" method="post" action="">');
				writeOutput('<input type="checkbox" name="event_1_important" id="event_1_important">');
				writeOutput('<label for="event_#jj#_important">Important</label>');
				writeOutput('<label for="entry_1_important"></label></form></td>');
	  		}
		}
	writeOutput('</table>');
</cfscript>
<cfinclude template="../includes/footer.cfm">