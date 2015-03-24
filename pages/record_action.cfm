<cfset pageTitle = "DOTLog Record Creation">
<cfinclude template="../includes/header.cfm">
<cfinclude template="../includes/banner.cfm">
    <a id="main_content"></a>
<cfinclude template="../includes/breadcrumb.cfm">
<cfinclude template="../includes/nav.cfm">
    <div id="content">

<h2>Event Review</h2>
<cfscript>
	databaseConnector = new dotlog.components.database();
	databaseConnector.saveRecord(Form.userID, Form.eventDescription);

	user = new dotlog.components.user("joe"); //should be passed in by the login page
	userID = user.getID();
	airports = user.getAirportID();

	cat = new dotlog.components.category();
	possibleCategories = cat.getCategoryNames();

	records = new dotlog.components.Record(user.getAirportID()[1]); 
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
<cfinclude template="../includes/footer.cfm">