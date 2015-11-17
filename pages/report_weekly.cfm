<cfset pageTitle = "DOTLog Reporting"> 
<cfinclude template="/dotlog/view/header.cfm">
<cfinclude template="/dotlog/view/print_reports.cfm">

<cfoutput><h2>#pageTitle#</h2></cfoutput>

<cfset airports = #application.airportService.getSpokeAirports(session.user.getAirportCode())#/>
<cfset categories = #application.categoryService.getAllCategories()#/>
<cfset reports = #application.reportService.getHubReports(session.user.getAirportCode())#/>
<cfset lastReport = #application.reportService.getLastWeeklyReport(session.user.getAirportCode())#/>
<cfset lastReportedDate = #lastReport.getEndDate()#/>

<table>
    <cfoutput><tr><td>Last Submitted Report for:<strong> #lastReport.getAirportCode()#</strong></tr></td></cfoutput>
    <cfoutput><tr><td>&nbsp;&nbsp;Period: #printDate(lastReport.getBeginDate())# to #printDate(lastReport.getEndDate())#</td></tr></cfoutput>
    <cfoutput><tr><td> &nbsp;&nbsp;Submitted by: #lastReport.getUsername()# </td><tr></cfoutput>
</table>

<br>

<cfset week = StructNew() />
<cfset week.today = (fix ( now () )) />
<cfset week.start = printDate(week.today - DayOfWeek(week.today) + 1) />
<cfset week.end = printDate( week.start + 6) />

<cfform name="weeklyReport" method="post" action="generateReport.cfm">
  <cfinput type="hidden" name="startDate" value="#week.start#"></cfinput>
  <cfinput type="hidden" name="endDate" value="#week.end#"></cfinput>
  <cfinput type="submit" name="viewWeeklyReport_button" value="View Report">
  <cfoutput> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </cfoutput>
  <cfinput type="submit" name="submitWeeklyReport_button" value="Submit Weekly Report"> <br>
  </table>
</cfform>

<cfinclude template="/dotlog/includes/footer.cfm">