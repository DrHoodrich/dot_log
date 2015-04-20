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
	if ( structKeyExists(FORM, 'newCategory_button') ) {
		records = [];
		if ( !isNull(FORM.username) ) {
			records = application.recordService.getRecordsByUsername(FORM.username);
		} else if ( !isNull(FORM.airportCode) ) {
			records = application.recordService.getRecordsByAirportCode(FORM.airportCode);
		}
	}
</cfscript>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">
