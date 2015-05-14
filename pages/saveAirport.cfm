<cfset pageTitle = "Save Airport"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/includes/header.cfm">
<cfinclude template="/dotlog/includes/banner.cfm">
  <a id="main_content"></a>
<cfinclude template="/dotlog/includes/breadcrumb.cfm">
<cfinclude template="/dotlog/includes/nav.cfm">
    <div id="content">
<cfscript>
	if ( structKeyExists(FORM, 'createAirport_button') ) {
		FORM.enabled = 1;		
	} else if ( structKeyExists(FORM, 'saveAirport_button') ) {
		if ( !structKeyExists(FORM,"enabled") ) {
			FORM.enabled = 0;
		}
	}

	airport = new dotlog.model.beans.airport(argumentCollection = FORM);

	if ( application.airportService.saveAirport(newAirport) ) {
		writeOutput("<h3>Saved airport " & newAirport.getAirportName() & "</h3>");
	} else {
		writeOutput("<h3>Failed to save airport " & newAirport.getAirportName() & "</h3>");
	}
</cfscript>
<cfinclude template="/dotlog/includes/footer.cfm">