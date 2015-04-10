<cfset pageTitle = "DOTLog Record Creation">
<cfinclude template="../includes/header.cfm">
<cfinclude template="../includes/banner.cfm">
    <a id="main_content"></a>
<cfinclude template="../includes/breadcrumb.cfm">
<cfinclude template="../includes/nav.cfm">
    <div id="content">
    
<!-- BEGIN YOUR CONTENT HERE -->
	<!-- TemplateBeginEditable name="main content" -->
<cfoutput><h2>#pageTitle#</h2></cfoutput>

	<cfscript>
		user = application.userService.getUserByUsername("us");  // <= set by LDAP
		airports = application.airportService.getChildAirports(user.getAirportFAACode());
		categories = application.categoryService.getAllCategories();
	</cfscript>

<cfform name="recordCreation" method="post" action="record_action.cfm">

<!--- Need to change how user info is passed into the action page --->
<cfscript>
	writeOutput('<input type="hidden" name="userID" value="#user.getUsername()#">');
</cfscript>
       
<label for="airportCode">Airport:</label>
	<cfselect name="airportCode">
			<cfscript>
				writeOutput('<option value="none"></option>');
				for (ii = 1; ii <= arrayLen(airports); ++ii) {
					writeOutput('<option value=#airports[ii].getFAACode()#>#airports[ii].getAirportName()#</option>');
				}
			</cfscript>
	</cfselect>

	 <br>
<label for="categoryTitle">Category:</label>
	<cfselect name="categoryTitle" id="categoryTitle">
		<cfscript>
			writeOutput('<option value="none"></option>');
			for (ii = 1; ii <= arrayLen(categories); ++ii) {
				writeOutput('<option value=#categories[ii].getCategoryTitle()#>#categories[ii].getCategoryTitle()#</option>');
			}
		</cfscript>
 	</cfselect>
    	
		<br>
<cftextarea name="eventDescription" cols="80" rows="10" id="eventDescription">Report Details</cftextarea>

		<br>
<label for="includeWeeklyReport">Include in weekly report:</label>
	<cfinput type="checkbox" name="includeWeeklyReport" value="1" id="includeWeeklyReport">
		
		<br>
<cfinput type="submit" name="addEvent" id="addEvent" value="Submit">
</cfform>
     
		<br>
<!--- Gets the latest records and displays under form entry --->		
<cfscript>
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
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="../includes/footer.cfm">