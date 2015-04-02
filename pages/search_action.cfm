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
	if ( structKeyExists(FORM, 'submitSearch_button') ) {
		dataSource = new dotlog.components.datasource("DOTlogDB","","");
		recordDOA = new dotlog.components.recordDAO(dataSource);
		records = [];
		writeDump(FORM);
		if ( !isNull(FORM.username) ) {
			records = recordDOA.getRecordsByUsername(FORM.username);
		} else if ( !isNull(FORM.faaCode) ) {
			records = recordDOA.getRecordsByAirportFAACode(FORM.faaCode);
		}
		writeDump(records);
	}
</cfscript>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="../includes/footer.cfm">