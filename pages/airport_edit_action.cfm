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
	user = application.userService.getUserByUsername("us");

	FORM.enabled = 1;

	if ( structKeyExists(FORM, 'submitFAACode_button') ) {
		dataSource = new dotlog.components.datasource("DOTlogDB","","");
		airportDOA = new dotlog.components.airportDAO(dataSource);
		
		writeDump(FORM);
		if ( !isNull(FORM.parentFAACode) ) {
			childAirports = airportDOA.getChildAirports(FORM.parentFAACode);
			writeDump(childAirports);
		}		
	}
</cfscript>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="../includes/footer.cfm">