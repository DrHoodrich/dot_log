<cfset pageTitle = "Daily Report"> 
<cfinclude template="/dotlog/view/header.cfm">
<cfinclude template="/dotlog/view/data_formatting.cfm">
<cfoutput><h2>#pageTitle#</h2></cfoutput>

<cfset airports = #application.airportService.getSpokeAirports(session.user.getAirportCode())#/>
<cfset categories = #application.categoryService.getAllCategories()#/>
<cfset reports = #application.reportService.getHubReports(session.user.getAirportCode())#/>
<cfset lastReport = #application.reportService.getLastReport(session.user.getAirportCode())#/>
<cfset lastReportedDate = #lastReport.getEndDate()#/>

<table>
    <cfoutput><tr><td>Last Submitted Report for:<strong> #lastReport.getAirportCode()#</strong></tr></td></cfoutput>
    <cfoutput><tr><td>&nbsp;&nbsp;Period:#printDate(lastReport.getBeginDate())# to #printDate(lastReport.getEndDate())#</td></tr></cfoutput>
    <cfoutput><tr><td> &nbsp;&nbsp;Submitted by: #lastReport.getUsername()# </td><tr></cfoutput>
</table>

<br>

<cfset week = StructNew() />
<cfset week.today = printDate(fix ( now () )) />

<cfform name="dailyReport" method="post" action="generateReport.cfm">
  <cfinput type="hidden" name="startDate" value="#week.today#"></cfinput>
  <cfinput type="hidden" name="endDate" value="#week.today#"></cfinput>
  <cfinput type="submit" name="viewDailyReport_button" value="View Report">
  <cfoutput> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </cfoutput>
  <cfinput type="submit" name="submitDailyReport_button" value="Submit Daily Report"> <br>
  </table>
</cfform>

<cfinclude template="/dotlog/includes/footer.cfm">