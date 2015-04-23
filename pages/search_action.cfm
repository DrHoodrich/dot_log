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

		/*
		if ( len(FORM.firstName) ) {
			searchStruct.firstName = FORM.firstName;
		}

		if ( len(FORM.lastName) ) {
			searchStruct.lastName = FORM.lastName;
		}*/

		if ( len(FORM.username) ) {
			searchStruct.username = FORM.username;
		}

		if ( len(FORM.keyword) ) {
			searchStruct.keyword = FORM.keyword;
		}

		if ( len(FORM.categoryTitle) ) {
			searchStruct.categoryTitle = FORM.categoryTitle;
		}

		if ( len(FORM.startDate) ) {
			searchStruct.startDate = FORM.startDate;
		}

		if ( len(FORM.endDate) ) {
			searchStruct.endDate = FORM.endDate;
		}

		if ( len(FORM.airportCode) ) {
			searchStruct.airportCode = FORM.airportCode;
		}

		if ( structKeyExists(FORM, 'included') ) {
			if ( len(FORM.included) ) {
				searchStruct.included = FORM.included;
			}
		}
		records = application.recordService.search(searchStruct);
	}
</cfscript>

<cfinclude template="/dotlog/view/print_reports.cfm">
<cfscript>
	writeOutput("<strong>Review Events to Report</strong>");

	printRecords(records);
</cfscript>

<cfform name="gerenateReport" action="generatePDF.cfm" method="post">
  <cfinput type="submit" name="generatePDF_button" value="View as PDF"/> <br>
</cfform>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">