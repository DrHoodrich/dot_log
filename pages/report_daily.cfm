<cfset pageTitle = "Daily Report"> <!--- Variable that is used in the html included header --->
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

    if (arrayLen(reports)) {
      writeOutput("<strong>Last Submitted Report</strong>");
      writeOutput('<table width="300" height="180" border="1">');
          writeOutput('<tr> <td width="117" height="50" align="left" valign="top"> 
            Reported dates #dateformat(reports[1].getBeginDate(), "yyyy-mm-dd")# - #dateformat(reports[1].getEndDate(), "yyyy-mm-dd")#<br>');
          writeOutput(' Submitted by User: #reports[1].getUsername()# <br>Airport: #reports[1].getAirportCode()# <br>');
          writeOutput('</td>');
      writeOutput('</table>');
    }


</cfscript>

<br>

<cfform name="dailyReport" method="post" action="generateReport.cfm">
  <cfinput type="hidden" name="startDate" value="#dateFormat(now(), 'yyyy-mm-dd')#"></cfinput>
  <cfinput type="hidden" name="endDate" value="#dateFormat(now(), 'yyyy-mm-dd')#"></cfinput>

  <cfinclude template="/dotlog/view/print_reports.cfm">

  <cfinput type="submit" name="submitDailyReport_button" value="Submit Daily Report"> <br>
  <cfinput type="submit" name="viewDailyReport_button" value="View Report"> <br>
</cfform>

<cfform name="dailyReport" method="post" action="stubbedGeneratePDF.cfm">
  <cfinput type="submit" name="submitReportEmail_button" value="Preview Report PDF"> // for dev
</cfform>
<cfinclude template="/dotlog/includes/footer.cfm">

