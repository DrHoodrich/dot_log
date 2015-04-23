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
    airports = application.airportService.getChildAirports(session.user.getAirportCode());
    categories = application.categoryService.getAllCategories();
    reports = application.reportService.getHubReports(session.user.getAirportCode());    
    lastReport = application.reportService.getLastReport(session.user.getAirportCode());
    lastReportedDate = lastReport.getEndDate();

    writeOutput("<strong>Submitted Reports</strong>");
    writeOutput('<table width="300" height="180" border="1">');
    writeOutput('<tr> <td width="117" height="50" align="left" valign="top">Reported dates #dateformat(reports[1].getBeginDate(), "yyyy-mm-dd")# - #dateformat(reports[1].getEndDate(), "yyyy-mm-dd")#<br>');
    writeOutput(' Submitted by User: #reports[1].getUsername()# <br>Airport: #reports[1].getAirportCode()# <br>');
    writeOutput('</td>');
    writeOutput('</table>');

    testReport = new dotlog.model.beans.report(session.user.getUsername(), session.user.getAirportCode(), now()-2, now()-1);

    reportDAO.saveReport(testReport);
</cfscript>

<br>


<cfform name="weeklyReport" method="post" action="generateReport.cfm">
  <cfinput type="hidden" name="startDate" value="#dateFormat(now()-2, 'yyyy-mm-dd')#"></cfinput>
  <cfinput type="hidden" name="endDate" value="#dateFormat(now()-1, 'yyyy-mm-dd')#"></cfinput>
<cfscript>
  
  
  record = '';
  records = [];
  if ( len(lastReportedDate) ) {
      records = application.recordService.getRecordsAfterDate(lastReportedDate);
  } else {
      for (ii = 1; ii <= arrayLen(airports); ++ii) {
        tmp = application.recordService.getRecordsByAirportCode(airports[ii].getAirportCode());        
        for (jj = 1; jj <= arrayLen(tmp); ++jj) {            
          arrayAppend(records, tmp[jj]);
        }
      }
  }
</cfscript>
<cfinclude template="/dotlog/view/print_reports.cfm">


<cfscript>
	writeOutput("<strong>Review Events to Report</strong>");
	printRecords(records);
</cfscript>

<cfinput type="submit" name="submitReportEmail_button" value="Email Report">
  <br>
</cfform>

<cfform name="weeklyReport" method="post" action="stubbedGeneratePDF.cfm">
  <cfinput type="submit" name="submitReportEmail_button" value="Preview Report PDF"> 
</cfform>
<cfinclude template="/dotlog/includes/footer.cfm">