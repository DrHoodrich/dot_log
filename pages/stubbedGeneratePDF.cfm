<cfdocument format="PDF" name="dailyReport">
    <cfoutput><strong>DOTLog Northern Region #dateformat(now(), "yyyy-mm-dd")# Report<hr></strong></cfoutput>
    
    <cfscript>
    	airports = application.airportService.getSpokeAirports(session.user.getAirportCode());
    	categories = application.categoryService.getAllCategories();

		for (ii = 1; ii <= arrayLen(airports); ++ii) {
			records = application.recordService.getRecordsByAirportCode(airports[ii].getAirportCode());
			for (jj = 1; jj <= arrayLen(records); ++jj) {
				checked = '';
				if (records[jj].isInWeeklyReport()) {
					checked = 'checked="True"';
				} else {
					continue;
				}
			}
		}
    </cfscript>
  
	<table width="783" height="180" border="1">
		<cfloop array="#records#" index="record">
			<cfset category = application.categoryService.getCategoryByID(record.getCategoryID())>
			<cfoutput><tr> <td width="117" height="102" align="left" valign="top"> #record.getEventTime()# <br></cfoutput>
			<cfoutput>Reporter: #record.getUsername()# <br>Airport: #record.getAirportCode()# <br> Category: #category.getCategoryTitle()# <br></cfoutput>
			<cfoutput><td width="560" align="left" valign="top">#record.getRecordText()#</td></cfoutput>
		</cfloop>
	</table>

</cfdocument>