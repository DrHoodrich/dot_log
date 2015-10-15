<cfdocument format="PDF" name="dailyReport">
	<cfinclude template="/dotlog/view/data_formatting.cfm">
	<cfinclude template="/dotlog/view/print_reports.cfm">
    <cfoutput><strong>DOTLog Northern Region #printDate(now())# Report<hr></strong></cfoutput>
    <cfset airports = #application.airportService.getHubAndSpokesAirports(session.user.getAirportCode())# />
    <cfloop array=#airports# index="airport">
    	<cfdump var=#airport.getAirportCode()#/>
	    <cfdump var=#application.recordService.getDailyReports(airport.getAirportCode())#>
    </cfloop>
</cfdocument>