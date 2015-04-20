<cfset pageTitle = "Seach Results"> <!--- Variable that is used in the html included header --->
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
	searchStruct = structNew();

	if ( structKeyExists(FORM, 'submitSearch_button') ) {
		dataSource = new dotlog.components.datasource("DOTlogDB","","");
		recordGW = new dotlog.components.recordGateway(dataSource);
	/*	if ( len(FORM.firstName) ) {
			searchStruct.firstName = FORM.firstName;
		}

		if ( len(FORM.lastName) ) {
			searchStruct.lastName = FORM.lastName;
		}
	*/

		if ( len(FORM.username) ) {
			searchStruct.username = FORM.username;
		}

		if ( len(FORM.keyword) ) {
			searchStruct.keyword = FORM.keyword;
		}

		if ( len(FORM.categoryTitle) ) {
			searchStruct.categoryTitle = FORM.categoryTitle;
		}

		if ( len(FORM.airportCode) ) {
			searchStruct.airportCode = FORM.airportCode;
		}

		records = recordGW.search(searchStruct);
		
		reportString = '';
		for (ii = 1; ii <= ArrayLen(records); ++ii) {
			reportString = reportString 
				& "<strong>Record Text:</strong>" & records[ii].getRecordText()
				& " <strong>Username:</strong> " & records[ii].getUsername()  
				&  " <strong>FAA Code:</strong> " & records[ii].getAirportCode() 
				&  " <strong>In Weekly Report:</strong> " & records[ii].isInWeeklyReport()
				&  " <strong>Event Time:</strong> " & records[ii].getEventTime()
				&  " <strong>Category:</strong> " & records[ii].getCategory()
				& "<br>";
		}
		writeOutput(reportString);
	}
</cfscript>

<cfform name="gerenateReport" action="generatePDF.cfm" method="post">
	<cfinput type="hidden" name="reports" value="#reportString#">
		
	</cfinput>
  <cfinput type="submit" name="generatePDF_button" value="Make PDF"> <br>
</cfform>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">