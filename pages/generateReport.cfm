<cfset pageTitle = "Daily Report"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/includes/header.cfm">
<cfinclude template="/dotlog/includes/banner.cfm">
	<a id="main_content"></a>
<cfinclude template="/dotlog/includes/breadcrumb.cfm">
<cfinclude template="/dotlog/includes/nav.cfm">
    <div id="content">


<cfscript>
	function getReportRecipients(required string airportCode, required string endHub)
	{
		var airport = application.airportService.getAirportByAirportCode(arguments.airportCode);
		var supervisors = [];
		if (airport.getAirportCode() == arguments.endHub) {
			return supervisors;
		} 
		
		var users = application.userService.getUsersByAirportCode(arguments.airportCode);
		var adminUsers = [];


		for (var ii = 1; ii <= arrayLen(users); ++ii) {
			if (users[ii].getPermissions()) {
				arrayAppend(adminUsers, users[ii]);
			}
		}

		var adminAirport = application.airportService.getAirportByAirportCode(adminUsers[1].getAirportCode());
		if (adminAirport.getParentAirportCode() == "root") { //making sure that we don't call a non existing airport.
			return adminUsers;
		}
				
		var parentAirport = application.airportService.getAirportByAirportCode(adminAirport.getParentAirportCode());

		
		supervisors = getReportRecipients(parentAirport.getAirportCode(), arguments.endHub);

		for (var ii = 1; ii <= arrayLen(supervisors); ++ii) {
			arrayAppend(adminUsers, supervisors[ii]);
		}
		return adminUsers;
	}
</cfscript>

	<cfscript>
		airports = application.airportService.getChildAirports(session.user.getAirportCode());
		arrayAppend(airports, application.airportService.getAirportByAirportCode(session.user.getAirportCode()));
		searchParameters = structNew();

		if ( structKeyExists(FORM,"submitDailyReport_button") || structKeyExists(FORM,"viewDailyReport_button")) {
			searchParameters.startDate = dateFormat(now(), 'yyyy-mm-dd');
			searchParameters.endDate = dateFormat(now(), 'yyyy-mm-dd');
			writeOutput("<strong>Submitted Report for #FORM.startDate#</strong><br><strong>Report Recipients</strong>");
			reportRecipients = getReportRecipients(session.user.getAirportCode(), "Statewide");
		}

		if ( structKeyExists(FORM,"submitWeeklyReport_button") || structKeyExists(FORM,"viewWeeklyReport_button")) {
			searchParameters.startDate = dateFormat(dateAdd("d", -7, now()), 'yyyy-mm-dd');
			searchParameters.endDate = dateFormat(now(), 'yyyy-mm-dd');
			searchParameters.included = 1;
			writeOutput("<strong>Submitted Report for #FORM.startDate# to #FORM.endDate#</strong><br><strong>Report Recipients</strong>");
			reportRecipients = getReportRecipients(session.user.getAirportCode(), "root");
		}
		
		todayRecords = [];
		for (ii = 1; ii <= arrayLen(airports); ++ii) {
		  searchParameters.airportCode = airports[ii].getAirportCode();
		  arrayAppend(todayRecords, application.recordService.search(searchParameters));
		  records = application.recordService.search(searchParameters);
		}


    todaysReport = new dotlog.model.beans.report(session.user.getUsername(), session.user.getAirportCode(), searchParameters.startDate, searchParameters.endDate);

    application.reportService.saveReport(todaysReport);

    
    
    
    
    writeOutput('<table frame="box">');
    writeOutput('<thead><tr><th>name</th><th>email address</th><th>Region/Hub</th></tr>');
    writeOutput('<tbody>');
    for (ii = 1; ii <= arrayLen(reportRecipients); ++ii) {
    	writeOUtput('<tr><td>'&reportRecipients[ii].getFullName() & "</td><td>" & reportRecipients[ii].getEmailAddr() & "</td><td>" &reportRecipients[ii].getAirportCode()&"</tr>");
    }
    writeOutput('</tbody>');
    writeOutput('</table>');
	</cfscript>
<cfinclude template="/dotlog/view/print_reports.cfm">
<cfscript>
	printRecords(records);
</cfscript>
    	

<!--- <cfmail from="tests@dotlog.gov" to="bucky@uafcsc.com" subject="Its late">
	<cfmailparam disposition="attachment" file="test.pdf" type="application/pdf" content="#pdfData#" > 

    NO BODY
</cfmail>
--->
<cfinclude template="/dotlog/includes/footer.cfm">