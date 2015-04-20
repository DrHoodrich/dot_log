<cfset pageTitle = "Edit Airport"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/includes/header.cfm">
<cfinclude template="/dotlog/includes/banner.cfm">
  <a id="main_content"></a>
<cfinclude template="/dotlog/includes/breadcrumb.cfm">
<cfinclude template="/dotlog/includes/nav.cfm">
    <div id="content">

<cfscript>
	existingAirport = "";
	if ( structKeyExists(FORM, 'saveAirport_button') ) {
		if (structKeyExists(FORM, 'enabled') ) {
			FORM.enabled = 1;
		} else {
			FORM.enabled = 0;
		}
		existingAirport = new dotlog.model.beans.airport(argumentCollection = FORM);
		
		if ( application.airportService.saveAirport(existingAirport) ) {
			writeOutput("<h3>Saved airport " & existingAirport.getAirportName() & "</h3>");
		} else {
			writeOutput("<h3>Failed to save airport " & existingAirport.getAirportName() & "</h3>");
		}	
	}
	structClear(FORM);
</cfscript>
  <!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">