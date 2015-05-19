<cfset pageTitle = "Add Airport"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/includes/header.cfm">
<cfinclude template="/dotlog/includes/banner.cfm">
    <a id="main_content"></a>
<cfinclude template="/dotlog/includes/breadcrumb.cfm">
<cfinclude template="/dotlog/includes/nav.cfm">
    <div id="content">
    
<!-- BEGIN YOUR CONTENT HERE -->
	<!-- TemplateBeginEditable name="main content" -->
<cfoutput><h2>#pageTitle#</h2></cfoutput>

<cffunction name="getAirportRegionID">
	<cfset regions = "#application.regionService.getAllRegions()#" />
	<cfform name="createAirport" action="add_airport.cfm" method="post">
		<table>
			<tr>
				<td>Airport's Region</td>
				<td>
					<cfselect name="airportRegionID">
						<option value="-1"/>--Region--</option>
						<cfloop index="region" array="#regions#">
							<cfoutput><option value="#region.getRegionID()#">#region.getRegionName()#</cfoutput>
						</cfloop>
					</cfselect>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><cfinput type="submit" name="selectRegion_button" value="Select"></td>
			</tr>
		</table>
	</cfform>
</cffunction>

<cffunction name="getAirportDistrictID">
	<cfset districts = "#application.districtService.getDistrictsByRegionID(FORM.airportRegionID)#" />
	<cfform name="createAirport" action="add_airport.cfm" method="post">
		<table>
			<tr>
				<td>Airport's District</td>
				<td>
					<cfselect name="airportDistrictID">
						<option value="-1"/>--District--</option>
						<cfloop index="district" array="#districts#">
							<cfoutput><option value="#district.getDistrictID()#">#district.getDistrictName()#</cfoutput>
						</cfloop>
					</cfselect>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><cfinput type="submit" name="selectDistrict_button" value="Select"></td>
			</tr>
		</table>
	</cfform>
</cffunction>

<cffunction name="getAirportHub">
	<cfset hubs = "#application.airportService.getHubAirportsByDistrictID(FORM.airportDistrictID)#" />
	<cfform name="createAirport" action="add_airport.cfm" method="post">
		<cfinput type="hidden" name="districtID" value="#FORM.airportDistrictID#"/>
		<table>
			<tr>
				<td>Airport's Hub</td>
				<td>
					<cfselect name="airportHubCode">
						<option value="-1"/>--New Hub--</option>
						<cfloop index="hub" array="#hubs#">
							<cfoutput><option value="#hub.getAirportCode()#">#hub.getAirportName()#</cfoutput>
						</cfloop>
					</cfselect>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><cfinput type="submit" name="selectHub_button" value="Select"></td>
			</tr>
		</table>
	</cfform>
</cffunction>

<cffunction name="setHubAirportValues">
	<cfform name="createAirport" action="saveAirport.cfm" method="post">
		<cfinput type="hidden" name="districtID" value="#FORM.districtID#"/>
		<cfinput type="hidden" name="enabled" value="1"/>
		<table>
			<tr>
				<td>Airport Name</td>
				<td><cfinput type="Text" name="airportName" message=""/></td>
			</tr>
			<tr>
				<td>FAA Code</td>
				<td><cfinput type="Text" name="airportCode" message=""/></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><cfinput type="submit" name="createHubAirport_button" value="Create Hub Airport"/></td>
			</tr>
		</table>
	</cfform>
</cffunction>

<cffunction name="setSpokeAirportValues">
	<cfform name="createAirport" action="saveAirport.cfm" method="post">
		<cfinput type="hidden" name="districtID" value="#FORM.districtID#"/>
		<cfinput type="hidden" name="hubCode" value="#FORM.airportHubCode#"/>
		<cfinput type="hidden" name="enabled" value="1"/>
		<table>
			<tr>
				<td>Airport Name</td>
				<td><cfinput type="Text" name="airportName" message=""/></td>
			</tr>
			<tr>
				<td>FAA Code</td>
				<td><cfinput type="Text" name="airportCode" message=""/></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><cfinput type="submit" name="createSpokeAirport_button" value="Create Spoke Airport"/></td>
			</tr>
		</table>
	</cfform>
</cffunction>
 
<cfscript>
	if ( !structKeyExists(FORM, "airportRegionID")  && !structKeyExists(FORM, "airportDistrictID")  && !structKeyExists(FORM, "airportHubCode") ) {
		getAirportRegionID();
	}
	if ( !structKeyExists(FORM, "airportDistrictID") && structKeyExists(FORM, "airportRegionID") ) {
		getAirportDistrictID();
	}
	if ( !structKeyExists(FORM, "airportHubCode") && structKeyExists(FORM, "airportDistrictID") ) {
		getAirportHub();
	}
	if ( structKeyExists(FORM, "airportHubCode") && FORM.airportHubCode == -1 ) {
		setHubAirportValues();
	}
	if ( structKeyExists(FORM, "airportHubCode") && FORM.airportHubCode > 0) {
		setSpokeAirportValues();
	}
</cfscript>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">