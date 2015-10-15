<cfset pageTitle = "Edit Event">
<cfinclude template="/dotlog/view/header.cfm">
<cfinclude template="/dotlog/view/data_formatting.cfm">
<cfoutput><h2>#pageTitle#</h2></cfoutput>

<cfscript>
	airports = application.airportService.getHubAndSpokesAirports(session.user.getAirportCode());
	
	categories = application.categoryService.getAllCategories();
	if ( structKeyExists(FORM, "recordID") ) {
		record = application.recordService.getRecordByID(FORM.recordID);
	}
</cfscript>

<cfform name="updateCategory" action="saveRecord.cfm" method="post">
	<table>
		<tr>
			<td>Reporter</td>
			<td><cfoutput> <strong>"#record.getUsername()#"</strong></cfoutput></td>
		</tr>
		<tr>
			<td>Airport</td>
			<td>
				<cfselect name="airportCode" required="true">
					<cfoutput><option value="#record.getAirportCode()#">#record.getAirportCode()#</option></cfoutput>
					<cfloop array="#airports#" index="airport">
						<cfoutput><option value="#airport.getAirportCode()#">#airport.getAirportCode() & "-" & airport.getAirportName()#</option></cfoutput>
					</cfloop>
				</cfselect>
			</td>
		</tr>
		<tr>
			<td>Category</td>
			<td>
				<cfselect name="categoryID"> 
  					<cfoutput><option value="#record.getCategoryID()#">"#record.getCategoryID()#"</option></cfoutput>
						<cfloop array="#categories#" index="category">
							<cfoutput><option value="#category.getCategoryID()#">#category.getCategoryID()#</option></cfoutput>
						</cfloop>
 				</cfselect>
 			</td>
		</tr>
		<tr>
			<td>Event Date</td>
			<td><cfinput type="text" name="eventDate" value="#printDate(record.getEventTime())#"></cfinput></td>
		</tr>
		<tr>
			<td>Event Time</td>
			<cfset eventTime = #printTime(record.getEventTime())#>
			<td><cfinput type="text" name="eventTime" value="#eventTime#"></cfinput></td>
		</tr>
		<tr>
			<td>Event Description</td>
			<td><cftextarea name="recordText" cols="40" rows="5" value="#record.getRecordText()#"></cftextarea></td>
		</tr>
		<tr>
			<td>Include In Weekly Report</td>
			<td><cfinput type="checkbox" name="inWeeklyReport" required="no" value="1" checked="#record.isInWeeklyReport()#"/></td>
		</tr>
	</table>
	<cfinput type="hidden" name="recordID" value="#record.getRecordID()#"></cfinput>
    <cfinput type="submit" name="updateRecord_button" value="Update Record"></cfinput>
</cfform>
<cfinclude template="/dotlog/includes/footer.cfm">