<cfset pageTitle = "Add Event">
<cfinclude template="/dotlog/view/header.cfm">
<cfoutput><h2>#pageTitle#</h2></cfoutput>

<cfset airports = #application.airportService.getHubAndSpokesAirports(session.user.getAirportCode())# />
<cfset categories = #application.categoryService.getAllCategories()# />

<cfform name="recordCreation" method="post" action="record_action.cfm">
	<!--- Need to change how user info is passed into the action page --->
	
	<input type="hidden" name="userID" value="#session.user.getUsername()#">
	
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
					<cfoutput><option value="-1">--Select Airport--</option></cfoutput>
					<cfloop index="airport" array="#airports#">
							<cfoutput><option value="#airport.getAirportCode()#">#airport.getAirportCode()# -- #airport.getAirportName()#</cfoutput>
						</cfloop>
				</cfselect>
			</td>
		</tr>
		<tr>
			<td>Category</td>
			<td>
				<cfselect name="categoryID">
					<cfoutput><option value="-1">--Select Category--</option></cfoutput>
					<cfloop index="category" array="#categories#">
							<cfoutput><option value="#category.getCategoryID()#">#category.getCategoryTitle()#</cfoutput>
						</cfloop>
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
<cfinclude template="/dotlog/includes/footer.cfm">
