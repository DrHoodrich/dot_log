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

<cfset airports = #application.airportService.getSpokeAirports(session.user.getAirportCode())#/>
<cfset categories = #application.categoryService.getAllCategories()#/>
<cfset reports = #application.reportService.getHubReports(session.user.getAirportCode())#/>
<cfset lastReport = #application.reportService.getLastReport(session.user.getAirportCode())#/>
<cfset lastReportedDate = #lastReport.getEndDate()#/>

<table>
  <!--- <cfloop index="report" array="#reports#"> --->
    <cfoutput><tr><td>Last Submitted Report for:<strong> #reports[1].getAirportCode()#</strong></tr></td></cfoutput>
    <cfoutput><tr><td>&nbsp;&nbsp;Period: #dateformat(reports[1].getBeginDate(), "yyyy-mm-dd")# to #dateformat(reports[1].getEndDate(), "yyyy-mm-dd")#</td></tr></cfoutput>
    <cfoutput><tr><td> &nbsp;&nbsp;Submitted by: #reports[1].getUsername()# </td><tr></cfoutput>
  <!--- </cfloop> --->
</table>

<br>

<cfform name="dailyReport" method="post" action="generateReport.cfm">
  <cfinput type="hidden" name="startDate" value="#dateFormat(now(), 'yyyy-mm-dd')#"></cfinput>
  <cfinput type="hidden" name="endDate" value="#dateFormat(now(), 'yyyy-mm-dd')#"></cfinput>
  <cfinput type="submit" name="viewDailyReport_button" value="View Report">
  <cfoutput> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </cfoutput>
  <cfinput type="submit" name="submitDailyReport_button" value="Submit Daily Report"> <br>
  </table>
</cfform>

<cfform name="dailyReport" method="post" action="stubbedGeneratePDF.cfm">
  <cfinput type="submit" name="submitReportEmail_button" value="Preview Report PDF"> // for dev
</cfform>
<cfinclude template="/dotlog/includes/footer.cfm">

