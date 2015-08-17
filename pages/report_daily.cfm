<cfset pageTitle = "Daily Report"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/view/header.cfm">
    
<!-- BEGIN YOUR CONTENT HERE -->
	<!-- TemplateBeginEditable name="main content" -->
<cfoutput><h2>#pageTitle#</h2></cfoutput>

<cfset airports = #application.airportService.getSpokeAirports(session.user.getAirportCode())#/>
<cfset categories = #application.categoryService.getAllCategories()#/>
<cfset reports = #application.reportService.getHubReports(session.user.getAirportCode())#/>
<cfset lastReport = #application.reportService.getLastReport(session.user.getAirportCode())#/>
<cfset lastReportedDate = #lastReport.getEndDate()#/>

<table>
    <cfoutput><tr><td>Last Submitted Report for:<strong> #lastReport.getAirportCode()#</strong></tr></td></cfoutput>
    <cfoutput><tr><td>&nbsp;&nbsp;Period: #dateformat(lastReport.getBeginDate(), "yyyy-mm-dd")# to #dateformat(lastReport.getEndDate(), "yyyy-mm-dd")#</td></tr></cfoutput>
    <cfoutput><tr><td> &nbsp;&nbsp;Submitted by: #lastReport.getUsername()# </td><tr></cfoutput>
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

