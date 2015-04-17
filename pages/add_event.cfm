<cfset pageTitle = "DOTLog Record Creation">
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
<cftextarea name="eventDescription" cols="80" rows="10" id="eventDescription">Event Summary</cftextarea>

		<br>
<label for="includeWeeklyReport">Include in Weekly Report:</label>
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
				writeOutput(' Reporter: #records[jj].getUsername()# <br>Airport: #records[jj].getAirportFAACode()# <br>');
				writeOutput('Category: #records[jj].getCategory()# <br>');
				writeOutput('<td width="560" align="left" valign="top">#records[jj].getRecordText()#</td>');
				writeOutput('<td width="92" align="right" valign="top">');
				if ( records[jj].isInWeeklyReport() ) {
					writeOutput('In Reports');
				}
				writeOutput('<form name="editRecord" method="post" action="edit_record_action.cfm"> <input type="hidden" name="recordID" value="#records[jj].getRecordID()#"> <input type="submit" name="editRecord" value="Edit Entry"> </form></td>');
	  		}
		}
	writeOutput('</table>');
</cfscript>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">