<cfset pageTitle = "DOTLog Reporting"> <!--- Variable that is used in the html included header --->
<cfinclude template="../includes/header.cfm">
<cfinclude template="../includes/banner.cfm">
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



<!--- Need to change how user info is passed into the action page --->
  

    <br>
<!--- Gets the latest records and displays under form entry --->    
<cfform name="weeklyReport" method="post" action="generateReport.cfm">
<cfscript>
  writeOutput('<table width="783" height="180" border="1">');
    for (ii = 1; ii <= arrayLen(airports); ++ii) {
      records = application.recordService.getRecordsByAirportFAACode(airports[ii].getFAACode());

      for (jj = 1; jj <= arrayLen(records); ++jj) {
        checked = '';
        if (records[jj].isInWeeklyReport()) {
          checked = 'checked="True"';
        } else {
          continue;
        }
        writeOutput('<tr> <td width="117" height="102" align="left" valign="top"> #records[jj].getEventTime()# <br>');
        writeOutput(' Reporter: #records[jj].getUsername()# <br>Airport: #records[jj].getAirportFAACode()# <br> Category: #records[jj].getCategory()# <br>');
        writeOutput('<td width="560" align="left" valign="top">#records[jj].getRecordText()#</td>');
        writeOutput('<td width="92" align="right" valign="top"><form name="form1" method="post" action="">');
        writeOutput('<input type="checkbox" name="event_#ii#_important" #checked#>');
        writeOutput('<label for="event_#jj#_important">Important</label>');
        writeOutput('<label for="entry_1_important"></label></form></td>');
      }
    }
  writeOutput('</table>');
</cfscript>
<cfinput type="submit" name="submitReportEmail_button" value="Email Report">
<cfinput type="submit" name="generateReportPDF_button" value="Preview Report PDF"> 
  <br>
</cfform>
<cfinclude template="../includes/footer.cfm">