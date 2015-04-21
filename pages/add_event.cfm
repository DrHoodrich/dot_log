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
	airports = application.airportService.getChildAirports(session.user.getAirportCode());
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
			<td><cfinput type="text" name="eventDate" required="true" message="Required time format hh:mm" validate="time" value="#dateformat(now(), 'hh:mm')#"/></td>
		</tr>
		<tr>
			<td>Airport</td>
			<td><cfselect name="airportCode" required="true">
					<cfscript>
						writeOutput('<option value="none"></option>');
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
				<cfselect name="categoryTitle" id="categoryTitle">
					<cfscript>
						writeOutput('<option value="none"></option>');
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
	printAirportRecords(airports);
</cfscript>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">
