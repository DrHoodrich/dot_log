<cfset pageTitle = "Save Airport"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/view/header.cfm">


<cffunction name="message">
	<cfargument name="details" type="string" required="true" default="" />
		<cfoutput><h3>#arguments.details#</h3></cfoutput>
</cffunction>


<cfscript>
	if ( structKeyExists(FORM, 'createHubAirport_button') ) {
			FORM.hubCode = FORM.airportCode;
			airport = new dotlog.model.beans.airport(argumentCollection = FORM);
			application.airportService.createAirport(airport);
	}
	if ( structKeyExists(FORM, 'createSpokeAirport_button') ) {
		FORM.enabled = 1;
		airport = new dotlog.model.beans.airport(argumentCollection = FORM);
		application.airportService.createAirport(airport);

	}
	if ( structKeyExists(FORM, 'editAirport_button') ) {
		if ( !structKeyExists(FORM,"enabled") ) {
			FORM.enabled = 0;
			airport = new dotlog.model.beans.airport(argumentCollection = FORM);
			application.airportService.createAirport(airport);
		}
	}

	airport = new dotlog.model.beans.airport(argumentCollection = FORM);

	if ( application.airportService.saveAirport(airport) ) {
		message("Saved airport " & airport.getAirportName());
	} else {
		message("Failed to save airport " & airport.getAirportName());
	}
</cfscript>
<cfinclude template="/dotlog/includes/footer.cfm">