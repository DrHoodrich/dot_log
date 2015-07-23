<cfset pageTitle = "Edit User"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/view/header.cfm">

<cfoutput><h2>#pageTitle#</h2></cfoutput>

<cffunction name="getUserRegionID">
	<cfset regions = "#application.regionService.getAllRegions()#" />
	<cfform name="editUser" action="edit_user.cfm" method="post">
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
	<cfform name="editUser" action="edit_user.cfm" method="post">
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
	<cfform name="editUser" action="edit_user.cfm" method="post">
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

<cffunction name="getUser">
	<cfset users = "#application.userService.getUsersByAirportCode(FORM.userHubCode)#" />
	<cfform name="editUser" action="edit_user.cfm" method="post">
		<table>
			<tr>
				<td>User</td>
				<td>
					<cfselect name="username">
						<option value="-1"/>--user--</option>
						<cfloop index="user" array="#users#">
							<cfoutput><option value="#user.getUsername()#">#user.getFullName()#</cfoutput>
						</cfloop>
					</cfselect>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><cfinput type="submit" name="selectUser_button" value="Select"></td>
			</tr>
		</table>
	</cfform>
</cffunction>

<cffunction name="editUserDetails">
	<cfset user = "#application.userService.getUserByUsername(FORM.username)#" />
	<cfform name="editUser" action="saveUser.cfm" method="post">
		<table>
			<tr>
				<td>Username</td>
				<td><cfoutput><strong>#user.getUsername()#</strong></cfoutput></td>
				<cfinput type="hidden" name="username" value="#user.getUsername()#"/>
			</tr>
			<tr>
				<td>Assigned Hub</td>
				<td><cfoutput><strong>#user.getAirportCode()#</strong></cfoutput></td>
				<cfinput type="hidden" name="airportCode" value="#user.getAirportCode()#"/>
			</tr>
			<tr>
				<td>First Name</td>
				<td><cfinput type="text" name="firstName" value="#user.getFirstName()#"/></td>
			</tr>
			<tr>
				<td>Last Name</td>
				<td><cfinput type="text" name="lastName" value="#user.getLastName()#"></td>
			</tr>
			<tr>
				<td>Email</td>
				<td><cfinput type="text" name="emailAddr" value="#user.getEmailAddr()#"></td>
			</tr>
			<tr>
				<td>Account Type</td>
				<td>
					<cfselect name = "permissions">
						<cfif user.getPermissions() IS True>
							<cfoutput><option value=#user.getPermissions()#>Admin</option></cfoutput>
							<option value=0>User</option>
						<cfelse>
							<cfoutput><option value=#user.getPermissions()#>User</option></cfoutput>
							<option value=1>Admin</option>
						</cfif>
					</cfselect>
				</td>
			</tr>
			<tr>
				<td>Active</td>
				<td><cfinput type="checkbox" name="enabled" value="#user.isEnabled()#" checked="#user.isEnabled()#" id="enabled"/></td>
			</tr>
			<tr>
				<td>Regional Manager</td>
				<td>
					<cfselect name="regionManager">
						<option value=0>No</option>
						<option value=1>Yes</option>
					</cfselect>
				</td>
			</tr>
			<tr>
				<td>District Manager</td>
				<td>
					<cfselect name="districtManager">
						<option value=0>No</option>
						<option value=1>Yes</option>
					</cfselect>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><cfinput type="submit" name="updateUser_button" value="Update User"></td>
			</tr>
		</table>
	</cfform>
</cffunction>

<cfscript>
	writeDump(FORM);
	if ( !structKeyExists(FORM, "userRegionID")  && !structKeyExists(FORM, "userDistrictID")  && !structKeyExists(FORM, "userHubCode") && !structKeyExists(FORM, "username")) {
		getUserRegionID();
	}
	if ( !structKeyExists(FORM, "userDistrictID") && structKeyExists(FORM, "userRegionID") ) {
		getUserDistrictID();
	}
	if ( !structKeyExists(FORM, "userHubCode") && structKeyExists(FORM, "userDistrictID") ) {
		getUserHub();
	}
	if ( structKeyExists(FORM, "userHubCode") && !structKeyExists(FORM, "userDistrictID") ) {
		getUser();
	}
	if ( structKeyExists(FORM, "username") && !structKeyExists(FORM, "userHubCode") ) {
		editUserDetails();
	}
</cfscript>
<cfinclude template="/dotlog/includes/footer.cfm">