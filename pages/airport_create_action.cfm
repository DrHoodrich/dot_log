<cfset pageTitle = "Create Airport Results"> <!--- Variable that is used in the html included header --->
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

	writeDump(FORM);
	if ( structKeyExists(FORM, 'createAirport_button') ) {
		FORM.enabled = 1;
		if ( len(FORM.parentFAACode) ) {

			writeOutput("Assigned to a Hub");

		} else {
			
			writeOutput("Is a new hub");
			FORM.parentFAACode = user.getAirportFAACode();

		}
		newAirport = new dotlog.components.airport(argumentCollection = FORM);
		createResult = application.airportService.saveAirport(newAirport);
		writeOutput(createResult);
	}
</cfscript>
<cfinclude template="../includes/footer.cfm">