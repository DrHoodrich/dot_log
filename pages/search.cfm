<cfset pageTitle = "DOTLog Search Stub"> <!--- Variable that is used in the html included header --->
<cfinclude template="../includes/header.cfm">
<cfinclude template="../includes/banner.cfm">
<cfinclude template="../includes/breadcrumb.cfm">
<cfinclude template="../includes/nav.cfm">
    <div id="content">
    
<!-- BEGIN YOUR CONTENT HERE -->
	<!-- TemplateBeginEditable name="main content" -->
<cfoutput><h2>#pageTitle#</h2></cfoutput>
  <cfscript>
  DBqueryHandler = new query();

    DBqueryHandler.setDataSource("DOTlogDB");

    DBqueryHandler.setName("irrelevant");

    queryResult = DBqueryHandler.execute(sql = "SELECT * FROM DL_AIRPORTS WHERE faa_code = 'AUK'");
    queryResult.getResult();

    writedump(queryResult)

    /**TODO
     * Get the hub ID from user to generate the list of airports
     * Get commonly used Categories?
     */
/*
    user = new dotlog.components.user("joe"); //should be passed in by the login page
    airports = user.getAirportID();

    cat = new dotlog.components.category();
    possibleCategories = cat.getCategoryNames();
  </cfscript>
    

  <cfform name="recordQuery" method="post" action=""> <!---Action is the page to send it to --->
       <cfinput type="text" name="dbSearchBar" id="dbSearchBar" value="Search"><br>
       <label for="dateRangeBegin">from:</label>
          <cfinput type="text" name="dateRangeBegin" id="dateRangeBegin" value="mm/dd/yyyy">
       <label for="dateRangeEnd">to:</label>
          <cfinput type="text" name="dateRangeEnd" id="dateRangeEnd" value="mm/dd/yyyy"><br>
       <label for="airportID">airport:</label>
           <cfselect name="airportID">
              <cfscript>
                writeOutput('<option value="none">none</option>');
                for (ii = 1; ii <= arrayLen(airports); ++ii) {
                  writeOutput('<option value=airports[ii]>#airports[ii]#</option>');
                }
              </cfscript>
           </cfselect>

           <br>
       <label for="eventCategory">Category:</label>
          <cfselect name="eventCategory" id="eventCategory">
            <cfscript>
              writeOutput('<option value="none">none</option>');
                for (ii = 1; ii <= arrayLen(possibleCategories); ++ii) {
                  writeOutput('<option value=airports[ii]>#possibleCategories[ii]#</option>');
                }
            </cfscript>
          </cfselect>
  </cfform>

<br>
<cfscript>
  records = new dotlog.components.Record();
  descriptions = records.getDescriptions();
  airport = records.getAirport();
  user = records.getReporter();
  category = records.getCategory();
  date = records.getDate();

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
*/
</cfscript>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="../includes/footer.cfm">