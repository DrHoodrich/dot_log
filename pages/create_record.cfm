<cfset pageTitle = "DOTLog Log Event">
<cfinclude template="../includes/header.cfm">
<cfinclude template="../includes/banner.cfm">
    <a id="main_content"></a>
<cfinclude template="../includes/breadcrumb.cfm">
<cfinclude template="../includes/nav.cfm">
    <div id="content">
    
<!-- BEGIN YOUR CONTENT HERE -->
	<!-- TemplateBeginEditable name="main content" -->
<cfoutput><h2>#pageTitle#</h2></cfoutput>

<!--- Hard coded until LDAP info. ---> 
	<cfscript>
		user = new dotlog.components.user("us"); //should be passed in by the login page
		username = "us";
		airport_faa_codes = user.getAirportFAACodes();
		airport_names = user.getAirportNames();

		categories = new dotlog.components.category();
		category_titles = categories.getCategoryTitles();
	</cfscript>

<cfform name="recordCreation" method="post" action="record_action.cfm">

<!--- Need to change how user info is passed into the action page --->
<cfscript>
	writeOutput('<input type="hidden" name="username" value="#username#">');
</cfscript>
       
<label for="faaCode">Airport:</label>
	<cfselect name="faaCode">
			<cfscript>
				writeOutput('<option value="none"></option>');
				for (ii = 1; ii <= arrayLen(airport_faa_codes); ++ii) {
					writeOutput('<option value="#airport_faa_codes[ii]#">#airport_names[ii]#</option>');
				}

			</cfscript>
	</cfselect>

	 <br>
<label for="CategoryTitle">Category:</label>
	<cfselect name="CategoryTitle">
		<cfscript>

			writeOutput('<option value="none"></option>');
			for (ii = 1; ii <= arrayLen(category_titles); ++ii) {
				writeOutput('<option value="#category_titles[ii]#">#category_titles[ii]#</option>');
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
	records = new dotlog.components.Record(airport_faa_codes[1]); 
	texts = records.getRecordText();
	airports = records.getRecordAirportFAACodes();
	users = records.getRecordUsers();
	categories = records.getRecordCategories();
	dates = records.getRecordTimes();

  //TODO: see about using cftable
  writeOutput('<table width="783" height="180" border="1">');
  for (ii = 1; ii <= arrayLen(texts); ++ii) {
		writeOutput('<tr> <td width="117" height="102" align="left" valign="top"> #dates[ii]# <br>');
		writeOutput('Reporter: #user[ii]# <br>Airport: #airports[ii]# <br> Category: #categories[ii]# <br>');
		writeOutput('<td width="560" align="left" valign="top">#texts[ii]#</td>');
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