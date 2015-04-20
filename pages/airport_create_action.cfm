<cfset pageTitle = "Create Airport Results"> <!--- Variable that is used in the html included header --->
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
		if ( structKeyExists(FORM, 'createAirport_button') ) {
		FORM.enabled = 1;
		if ( len(FORM.parentAirportCode) ) {
			writeOutput("Assigned to a Hub");
		} else {
			FORM.parentAirportCode = session.user.getAirportCode();
		}
		newAirport = new dotlog.model.airport(argumentCollection = FORM);

		if ( application.airportService.saveAirport(newAirport) ) {
			writeOutput("<h3>Saved airport " & newAirport.getAirportName() & "</h3>");
		} else {
			writeOutput("<h3>Failed to save airport " & newAirport.getAirportName() & "</h3>");
		}	
	}
</cfscript>
<cfinclude template="/dotlog/includes/footer.cfm">