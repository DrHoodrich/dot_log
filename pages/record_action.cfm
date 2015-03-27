<cfset pageTitle = "DOTLog Record Creation">
<cfinclude template="../includes/header.cfm">
<cfinclude template="../includes/banner.cfm">
    <a id="main_content"></a>
<cfinclude template="../includes/breadcrumb.cfm">
<cfinclude template="../includes/nav.cfm">
    <div id="content">

<cfoutput><h2>#pageTitle#</h2></cfoutput>
<cfscript>
	databaseConnector = new dotlog.components.database();
	databaseConnector.saveRecord(Form.userID, Form.eventDescription);

	user = new dotlog.components.user("joe"); //should be passed in by the login page
	userID = user.getID();
	airportIDs = user.getAirportIDs();
	airportNames = user.getAirportNames();

	categories = new dotlog.components.category();
	categoryNames = categories.getCategoryNames();
	categoryIDs = categories.getCategoryIDs();

	records = new dotlog.components.Record(airportIDs[1]); 
	descriptions = records.getDescriptions();
	airport = records.getAirport();
	user = records.getReporter();
	category = records.getCategory();
	date = records.getDate();

  //TODO: fix indexing of airports and category names from ii
  writeOutput('<table width="783" height="180" border="1">');
  for (ii = 1; ii <= arrayLen(descriptions); ++ii) {
		writeOutput('<tr> <td width="117" height="102" align="left" valign="top"> #date[ii]# <br>');
		writeOutput(' Reporter: #user[ii]# <br>Airport: #airportNames[1]# <br> Category: #categoryNames[1]# <br>');
		writeOutput('<td width="560" align="left" valign="top">#descriptions[ii]#</td>');
		writeOutput('<td width="92" align="right" valign="top"><form name="form1" method="post" action="">');
		writeOutput('<input type="checkbox" name="event_1_important" id="event_1_important">');
		writeOutput('<label for="event_#ii#_important">Important</label>');
		writeOutput('<label for="entry_1_important"></label></form></td>');
  }
  writeOutput('</table>');
</cfscript>
<cfinclude template="../includes/footer.cfm">