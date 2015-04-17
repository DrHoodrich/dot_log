<cfset pageTitle = "DOTLog Reporting"> <!--- Variable that is used in the html included header --->
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
    airports = application.airportService.getChildAirports(session.user.getAirportFAACode());
    categories = application.categoryService.getAllCategories();

    datasource = new dotlog.components.datasource(DSName = "DOTlogDB", username = "", password = "");
    reportDAO = new dotlog.components.reportDAO(datasource);
    reportGW = new dotlog.components.reportGateway(datasource);
    reports = reportGW.getHubReports(session.user.getAirportFAACode());    

    lastReport = reportDAO.getLastReport(session.user.getAirportFAACode());
    lastReportedDate = lastReport.getEndDate();

    writeOutput("<strong>Submitted Reports</strong>");
    writeOutput('<table width="300" height="180" border="1">');
    for (ii = 1; ii <= arrayLen(reports); ++ii) {
        writeOutput('<tr> <td width="117" height="50" align="left" valign="top"> 
          Reported dates #dateformat(reports[ii].getBeginDate(), "yyyy-mm-dd")# - #dateformat(reports[ii].getEndDate(), "yyyy-mm-dd")#<br>');
        writeOutput(' Submitted by User: #reports[ii].getUsername()# <br>Airport: #reports[ii].getAirportCode()# <br>');
        writeOutput('</td>');
    }
    writeOutput('</table>');

    testReport = new dotlog.components.report(session.user.getUsername(), session.user.getAirportFAACode(), now()-2, now()-1);

    reportDAO.saveReport(testReport);
</cfscript>

<br>


<cfform name="weeklyReport" method="post" action="generateReport.cfm">
  <cfinput type="hidden" name="startDate" value="#dateFormat(now()-2, 'yyyy-mm-dd')#"></cfinput>
  <cfinput type="hidden" name="endDate" value="#dateFormat(now()-1, 'yyyy-mm-dd')#"></cfinput>
<cfscript>
  writeOutput("<strong>Review Events to Report</strong>");
  writeOutput('<table width="783" height="180" border="1">');

  record = '';
  records = [];
  if ( len(lastReportedDate) ) {
      records = application.recordService.getRecordsAfterDate(lastReportedDate);
  } else {
      for (ii = 1; ii <= arrayLen(airports); ++ii) {
        tmp = application.recordService.getRecordsByAirportFAACode(airports[ii].getFAACode());        
        for (jj = 1; jj <= arrayLen(tmp); ++jj) {            
          arrayAppend(records, tmp[jj]);
        }
      }
  }

  for (ii = 1; ii <= arrayLen(records); ++ii) {
    checked = '';
    if (records[ii].isInWeeklyReport()) { 
      checked = 'checked="True"';
    } else {
      continue;
    }
    writeOutput('<tr> <td width="117" height="102" align="left" valign="top"> #records[ii].getEventTime()# <br>');
    writeOutput(' Reporter: #records[ii].getUsername()# <br>Airport: #records[ii].getAirportFAACode()# <br> Category: #records[ii].getCategory()# <br>');
    writeOutput('<td width="560" align="left" valign="top">#records[ii].getRecordText()#</td>');
    writeOutput('<td width="92" align="right" valign="top">');
    writeOutput('In Reports');
    writeOutput('<form name="editRecord" method="post" action="edit_record_action.cfm"> <input type="hidden" name="recordID" value="#records[ii].getRecordID()#"> <input type="submit" name="editRecord" value="Edit Entry"> </form></td>');
  }
  writeOutput('</table>');
</cfscript>
<cfinput type="submit" name="submitReportEmail_button" value="Email Report">
  <br>
</cfform>

<cfform name="weeklyReport" method="post" action="stubbedGeneratePDF.cfm">
  <cfinput type="submit" name="submitReportEmail_button" value="Preview Report PDF"> 
</cfform>
<cfinclude template="/dotlog/includes/footer.cfm">