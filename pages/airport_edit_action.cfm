<cfset pageTitle = "Edit Airfield"> <!--- Variable that is used in the html included header --->
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
		
	existingAirport = "";
	if ( structKeyExists(FORM, 'selectAirportToEdit_button') ) {
		existingAirport = application.airportService.getAirportByFAACode(FORM.faaCode);
		FORM.parentAirportFAACode = existingAirport.getParentAirportFAACode();
		FORM.enabled = existingAirport.isEnabled();
		FORM.airportName = existingAirport.getAirportName();
	} else if ( structKeyExists(FORM, "editAirport_button")) {
		if (structKeyExists(FORM, 'enabled') ) {
			FORM.enabled = 1;
		} else {
			FORM.enabled = 0;
		}
		existingAirport = new dotlog.components.airport(argumentCollection = FORM);
		successfulUpdate = application.airportService.saveAirport(existingAirport);
	}
	structClear(FORM);
</cfscript>

<cfif structKeyExists(FORM, 'editAirport_button') IS False>
	<cfform name="editAirport" method="post" action="airport_edit_action.cfm">
					
		<label for="faaCode">airport FAA Code:</label>
			<cfoutput>
				<strong>#existingAirport.getFAACode()#</strong>
			</cfoutput> <br>
			<cfinput type="hidden" name="FAACode" value="#existingAirport.getFAACode()#"/>

		<label for="airportName">airport Name:</label>
			<cfinput type="text" name="airportName" value="#existingAirport.getAirportName()#"> <br>

		<label for="parentFAACode">Parent FAA Code:</label>
			<cfinput type="text" name="parentFAACode" value="#existingAirport.getParentAirportFAACode()#"> <br>

		<label for="enabled">Enabled:</label>
			<cfinput type="checkbox" name="enabled" value="#existingAirport.isEnabled()#" checked="#existingAirport.isEnabled()#" id="enabled"> <br>
			
		<cfinput type="submit" name="editAirport_button" id="editAirport_button" value="Edit">
	</cfform>
</cfif>
<cfinclude template="../includes/footer.cfm">