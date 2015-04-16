<cfset pageTitle = "Edit Airport"> <!--- Variable that is used in the html included header --->
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
	existingAirport = application.airportService.getAirportByFAACode(FORM.faaCode);
</cfscript>

<cfif structKeyExists(FORM, 'selectAirportToEdit_button')>
	<cfform name="editAirport" method="post" action="saveAirport.cfm">
					
		<label for="faaCode">FAA Code:</label>
			<cfoutput>
				<strong>#existingAirport.getFAACode()#</strong>
			</cfoutput> <br>
			<cfinput type="hidden" name="FAACode" value="#existingAirport.getFAACode()#"/>

		<label for="airportName">Airport Name:</label>
			<cfinput type="text" name="airportName" value="#existingAirport.getAirportName()#"> <br>

		<label for="parentFAACode">Parent FAA Code:</label>
			<cfinput type="text" name="parentFAACode" value="#existingAirport.getParentAirportFAACode()#"> <br>

		<label for="enabled">Enabled:</label>
			<cfinput type="checkbox" name="enabled" value="#existingAirport.isEnabled()#" checked="#existingAirport.isEnabled()#" id="enabled"> <br>
			
		<cfinput type="submit" name="saveAirport_button" value="Edit">
	</cfform>
</cfif>
<cfinclude template="../includes/footer.cfm">