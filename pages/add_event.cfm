<cfset pageTitle = "Add Event">
<cfinclude template="/dotlog/includes/header.cfm">
<cfinclude template="/dotlog/includes/banner.cfm">
    <a id="main_content"></a>
<cfinclude template="/dotlog/includes/breadcrumb.cfm">
<cfinclude template="/dotlog/includes/nav.cfm">
    <div id="content">
    
<!-- BEGIN YOUR CONTENT HERE -->
	<!-- TemplateBeginEditable name="main content" -->
<cfoutput><h2>#pageTitle#</h2></cfoutput>

<cfscript>
	childAirports = application.airportService.getSpokeAirports(session.user.getAirportCode());

	airports = [];

	for (ii = 1; ii <= arrayLen(childAirports); ++ii) {
		temp = application.airportService.getSpokeAirports(childAirports[ii].getAirportCode());
		arrayPrepend(temp, childAirports[ii]);
		arrayAppend(airports, temp);
		for (jj = 2; jj <= arrayLen(temp); ++jj) {
			temp2 = application.airportService.getSpokeAirports(temp[jj].getAirportCode());
			arrayAppend(airports, temp2);
			for (kk = 1; kk <= arrayLen(temp2); ++kk) {
				temp3 = application.airportService.getSpokeAirports(temp2[kk].getAirportCode());
				arrayAppend(airports, temp3);
			}
		}
	}

	categories = application.categoryService.getAllCategories();
</cfscript>

<cfform name="recordCreation" method="post" action="record_action.cfm">
	<!--- Need to change how user info is passed into the action page --->
	<cfscript>
		writeOutput('<input type="hidden" name="userID" value="#session.user.getUsername()#">');
	</cfscript>

	<table>
		<tr>
			<td>Event Date</td>
			<td><cfinput type="datefield" name="eventDate" message="" required="true" value="#dateformat(now(), 'dd/mm/yyyy')#"/></td>
		</tr>
		<tr>
			<td>Event Time</td>
			<td><cfinput type="text" name="eventTime" required="true" message="Required time format hh:mm" validate="time" value="#timeformat(now(), 'hh:mm tt')#"/></td>
		</tr>
		<tr>
			<td>Airport</td>
			<td>
				<cfselect name="airportCode" required="true">
					<cfoutput><option value="#session.user.getAirportCode()#">#session.user.getAirportCode()#</option></cfoutput>
					<cfscript>
						for (ii = 1; ii <= arrayLen(airports); ++ii) {
							for (jj = 1; jj <= arrayLen(airports[ii]); ++jj) {
								writeOutput('<option value=#airports[ii][jj].getAirportCode()#>#airports[ii][jj].getAirportCode()&' - '&airports[ii][jj].getAirportName()#</option>');
							}
						}
					</cfscript>
				</cfselect>
			</td>
		</tr>
		<tr>
			<td>Category</td>
			<td>
				<cfselect name="categoryTitle" id="categoryTitle">
					<cfoutput><option value="">--select category--</option></cfoutput>
					<cfscript>
						for (ii = 1; ii <= arrayLen(categories); ++ii) {
							writeOutput('<option value=#categories[ii].getCategoryTitle()#>#categories[ii].getCategoryTitle()#</option>');
						}
					</cfscript>
	 			</cfselect>
	 		</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td><cftextarea name="eventDescription" cols="80" rows="10" id="eventDescription" required="true" message="Event Summary Required" placeholder="Event Summary"/></td>
		</tr>
		<tr>
			<td>Include in Weekly Report</td>
			<td><cfinput type="checkbox" name="includeWeeklyReport" value="1" id="includeWeeklyReport"/></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td><cfinput type="submit" name="addEvent" id="addEvent" value="Submit"/></td>
		</tr>
	</table>
</cfform>
     
		<br>
<!--- Gets the latest records and displays under form entry --->		
<cfinclude template="/dotlog/view/print_reports.cfm">
<cfscript>
	for (ii = 1; ii <= arrayLen(airports); ++ii) {
		printAirportRecords(airports[ii]);
	}
</cfscript>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">
