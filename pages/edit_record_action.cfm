<cfset pageTitle = "Edit Event">
<cfinclude template="/dotlog/view/header.cfm">
<cfoutput><h2>#pageTitle#</h2></cfoutput>

<cfscript>
	airports = application.airportService.getChildAirports(session.user.getAirportCode());
	arrayAppend(airports, application.airportService.getAirportByAirportCode(session.user.getAirportCode()));
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
					<cfscript>
						for (ii = 1; ii <= arrayLen(airports); ++ii) {
							writeOutput('<option value=#airports[ii].getAirportCode()#>#airports[ii].getAirportCode()&' - '&airports[ii].getAirportName()#</option>');
						}
					</cfscript>
				</cfselect>
			</td>
		</tr>
		<tr>
			<td>Category</td>
			<td>
				<cfselect name="categoryTitle"> 
  					<cfscript>
						writeOutput('<option value="#record.getCategory()#">"#record.getCategory()#"</option>');
						for (ii = 1; ii <= arrayLen(categories); ++ii) {
							writeOutput('<option value=#categories[ii].getCategoryTitle()#>#categories[ii].getCategoryTitle()#</option>');
						}  
  					</cfscript>
 				</cfselect>
 			</td>
		</tr>
		<tr>
			<td>Event Date</td>
			<td><cfinput type="text" name="eventDate" value="#dateformat(record.getEventTime(), 'dd/mm/yyyy')#"></cfinput></td>
		</tr>
		<tr>
			<td>Event Time</td>
			<cfset eventTime = #timeformat(record.getEventTime(), 'hh:mm tt')#>
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