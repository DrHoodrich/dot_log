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
	writedump(Form);
	databaseConnector.saveRecord(Form.eventDescription, Form.username, Form.faaCode, Form.CategoryTitle);

	user = new dotlog.components.user("us"); //should be passed in by the login page
	username = "us";
	airport_faa_codes = user.getAirportFAACodes();
	airport_names = user.getAirportNames();

	categories = new dotlog.components.category();
	category_titles = categories.getCategoryTitles();

	records = new dotlog.components.Record(airport_faa_codes[1]); 
	texts = records.getRecordTexts();
	airports = records.getRecordAirportFAACodes();
	users = records.getRecordUsers();
	dates = records.getRecordTimes();

  //TODO: fix indexing of airports and category names from ii
  writeOutput('<table width="783" height="180" border="1">');
  for (ii = 1; ii <= arrayLen(descriptions); ++ii) {
		writeOutput('<tr> <td width="117" height="102" align="left" valign="top"> #dates[ii]# <br>');
		writeOutput('Reporter: #users[ii]# <br>Airport: #airport_faa_codes[1]# <br> Category: #category_titles[1]# <br>');
		writeOutput('<td width="560" align="left" valign="top">#texts[ii]#</td>');
		writeOutput('<td width="92" align="right" valign="top"><form name="form1" method="post" action="">');
		writeOutput('<input type="checkbox" name="event_1_in_weekly_report" id="event_1_in_weekly_report">');
		writeOutput('<label for="event_#ii#_in_weekly_report">Included in Weekly Report</label>');
		writeOutput('<label for="entry_1_in_weekly_report"></label></form></td>');
  }
  writeOutput('</table>');
</cfscript>
<cfinclude template="../includes/footer.cfm">