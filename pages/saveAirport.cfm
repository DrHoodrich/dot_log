<cfset pageTitle = "Save Airport"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/includes/header.cfm">
<cfinclude template="/dotlog/includes/banner.cfm">
  <a id="main_content"></a>
<cfinclude template="/dotlog/includes/breadcrumb.cfm">
<cfinclude template="/dotlog/includes/nav.cfm">
    <div id="content">
<cfscript>

	if ( structKeyExists(FORM, 'createHubAirport_button') ) {
			FORM.hubCode = FORM.airportCode;
	}
	if ( structKeyExists(FORM, 'createSpokeAirport_button') ) {
		FORM.enabled = 1;		
	} else if ( structKeyExists(FORM, 'saveAirport_button') ) {
		if ( !structKeyExists(FORM,"enabled") ) {
			FORM.enabled = 0;
		}
	}
	writeDump(FORM);
	airport = new dotlog.model.beans.airport(argumentCollection = FORM);

	if ( application.airportService.saveAirport(airport) ) {
		writeOutput("<h3>Saved airport " & airport.getAirportName() & "</h3>");
	} else {
		writeOutput("<h3>Failed to save airport " & airport.getAirportName() & "</h3>");
	}
</cfscript>
<cfinclude template="/dotlog/includes/footer.cfm">