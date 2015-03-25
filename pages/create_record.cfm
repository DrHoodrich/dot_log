<cfset pageTitle = "DOTLog Record Creation">
<cfinclude template="../includes/header.cfm">
<cfinclude template="../includes/banner.cfm">
    <a id="main_content"></a>
<cfinclude template="../includes/breadcrumb.cfm">
<cfinclude template="../includes/nav.cfm">
    <div id="content">
    
<!-- BEGIN YOUR CONTENT HERE -->
	<!-- TemplateBeginEditable name="main content" -->
<h2>DOTLog Log Record</h2>

<!--- Hard coded until LDAP info. ---> 
	<cfscript>
		user = new dotlog.components.user("joe"); //should be passed in by the login page
		userID = user.getID();
		airportIDs = user.getAirportIDs();
		airportNames = user.getAirportNames();

		categories = new dotlog.components.category();
		categoryNames = categories.getCategoryNames();
		categoryIDs = categories.getCategoryIDs();
	</cfscript>

<cfform name="recordCreation" method="post" action="record_action.cfm">

<!--- Need to change how user info is passed into the action page --->
<cfscript>
	writeOutput('<input type="hidden" name="userID" value="#userID#">');
</cfscript>
       
<label for="airportCode">Airport:</label>
	<cfselect name="airportCode">
			<cfscript>
				writeOutput('<option value="none"></option>');
				for (ii = 1; ii <= arrayLen(airportIDs); ++ii) {
					writeOutput('<option value=#airportIDs[ii]#>#airportNames[ii]#</option>');
				}
			</cfscript>
	</cfselect>

	 <br>
<label for="eventCategory">Category:</label>
	<cfselect name="eventCategory" id="eventCategory">
		<cfscript>
			writeOutput('<option value="none"></option>');
			for (ii = 1; ii <= arrayLen(categoryNames); ++ii) {
				writeOutput('<option value=#categoryIDs[ii]#>#categoryNames[ii]#</option>');
			}
		</cfscript>
 	</cfselect>
    	
		<br>
<cftextarea name="eventDescription" cols="80" rows="10" id="eventDescription">Report Details</cftextarea>

		<br>
<label for="includeWeeklyReport">Include in weekly report:</label>
	<cfinput type="checkbox" name="includeWeeklyReport" value="yes" id="includeWeeklyReport">
		
		<br>
<cfinput type="submit" name="addEvent" id="addEvent" value="Submit">
</cfform>
     
		<br>
<!--- Gets the latest records and displays under form entry --->		
<cfscript>
	records = new dotlog.components.Record(airportIDs[1]); 
	descriptions = records.getDescriptions();
	airport = records.getAirport();
	user = records.getReporter();
	category = records.getCategory();
	date = records.getDate();

  //TODO: see about using cftable
  writeOutput('<table width="783" height="180" border="1">');
  for (ii = 1; ii <= arrayLen(descriptions); ++ii) {
		writeOutput('<tr> <td width="117" height="102" align="left" valign="top"> #date[ii]# <br>');
		writeOutput(' Reporter: #user[ii]# <br>Airport: #airport[ii]# <br> Category: #category[ii]# <br>');
		writeOutput('<td width="560" align="left" valign="top">#descriptions[ii]#</td>');
		writeOutput('<td width="92" align="right" valign="top"><form name="form1" method="post" action="">');
		writeOutput('<input type="checkbox" name="event_1_important" id="event_1_important">');
		writeOutput('<label for="event_#ii#_important">Important</label>');
		writeOutput('<label for="entry_1_important"></label></form></td>');
  }
  writeOutput('</table>');
</cfscript>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="../includes/footer.cfm">