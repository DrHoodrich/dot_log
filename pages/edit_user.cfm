<cfset pageTitle = "Edit User"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/includes/header.cfm">
<cfinclude template="/dotlog/includes/banner.cfm">
	<a id="main_content"></a>
<cfinclude template="/dotlog/includes/breadcrumb.cfm">
<cfinclude template="/dotlog/includes/nav.cfm">
    <div id="content">

<cfoutput><h2>#pageTitle#</h2></cfoutput>

<cffunction name="getUserRegionID">
	<cfset regions = "#application.regionService.getAllRegions()#" />
	<cfform name="createUser" action="edit_user.cfm" method="post">
		<table>
			<tr>
				<td>User's Region</td>
				<td>
					<cfselect name="userRegionID">
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

<cffunction name="getUserDistrictID">
	<cfset districts = "#application.districtService.getDistrictsByRegionID(FORM.userRegionID)#" />
	<cfform name="createUser" action="edit_user.cfm" method="post">
		<table>
			<tr>
				<td>User's District</td>
				<td>
					<cfselect name="userDistrictID">
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

<cffunction name="getUserHub">
	<cfset hubs = "#application.airportService.getHubAirportsByDistrictID(FORM.userDistrictID)#" />
	<cfform name="createUser" action="edit_user_action.cfm" method="post">
		<table>
			<tr>
				<td>User's Hub</td>
				<td>
					<cfselect name="userHubCode">
						<option value="-1"/>--Hub Airport--</option>
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

<cfscript>
	if ( !structKeyExists(FORM, "userRegionID")  && !structKeyExists(FORM, "userDistrictID")  && !structKeyExists(FORM, "userHubCode")) {
		getUserRegionID();
	}
	if ( !structKeyExists(FORM, "userDistrictID") && structKeyExists(FORM, "userRegionID") ) {
		getUserDistrictID();
	}
	if ( !structKeyExists(FORM, "userHubCode") && structKeyExists(FORM, "userDistrictID") ) {
		getUserHub();
	}
	if ( structKeyExists(FORM, "userHubCode") ) {
		getUserDetails();
	}
</cfscript>
<cfinclude template="/dotlog/includes/footer.cfm">