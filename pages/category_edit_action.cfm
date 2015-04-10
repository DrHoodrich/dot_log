<cfset pageTitle = "Seach Results"> <!--- Variable that is used in the html included header --->
<cfinclude template="../includes/header.cfm">
<cfinclude template="../includes/banner.cfm">
	<a id="main_content"></a>
<cfinclude template="../includes/breadcrumb.cfm">
<cfinclude template="../includes/nav.cfm">
    <div id="content">
    
<!-- BEGIN YOUR CONTENT HERE -->
	<!-- TemplateBeginEditable name="main content" -->
<cfoutput><h2>#pageTitle#</h2></cfoutput>

<cfscript>
	if ( structKeyExists(FORM, 'newCategory_button') ) {
		records = [];
		writeDump(FORM);
		if ( !isNull(FORM.username) ) {
			records = application.recordService.getRecordsByUsername(FORM.username);
		} else if ( !isNull(FORM.faaCode) ) {
			records = application.recordService.getRecordsByAirportFAACode(FORM.faaCode);
		}
		writeDump(records);
	}
</cfscript>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="../includes/footer.cfm">