<cfset pageTitle = "Edit Airport"> <!--- Variable that is used in the html included header --->
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
	existingAirport = application.airportService.getAirportByAirportCode(FORM.airportCode);
	hubAirports = application.airportService.getChildAirports(session.user.getAirportCode());
</cfscript>

<cfif structKeyExists(FORM, 'selectAirportToEdit_button')>
	<cfform name="editAirport" method="post" action="saveAirport.cfm">
		<cfinput type="hidden" name="airportCode" value="#existingAirport.getAirportCode()#"/>
		<table>
			<tr>
				<td>FAA Code</td>
				<td><cfoutput><strong>#existingAirport.getAirportCode()#</strong></cfoutput></td>
			</tr>
			<tr>
				<td>Airport Name</td>
				<td><cfinput type="text" name="airportName" value="#existingAirport.getAirportName()#"/></td>
			</tr>		
			<tr>
				<td>Parent FAA Code</td>
				<td>
					<cfselect name = "parentAirportCode"> 
						<cfoutput><option value="#existingAirport.getParentAirportCode()#">#existingAirport.getParentAirportCode()#</option></cfoutput>
						<cfscript>
							for (ii = 1; ii <= arrayLen(hubAirports); ++ii) {
								writeOutput('<option value="#hubAirports[ii].getAirportCode()#">#hubAirports[ii].getAirportCode()#</option>');
							}
						</cfscript>
					</cfselect>
				</td>
			</tr>
			<tr>
				<td>Active</td>
				<td><cfinput type="checkbox" name="enabled" value="#existingAirport.isEnabled()#" checked="#existingAirport.isEnabled()#" id="enabled"/></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><cfinput type="submit" name="saveAirport_button" value="Update"/></td>
			</tr>
		</table>
	</cfform>
</cfif>
<cfinclude template="/dotlog/includes/footer.cfm">