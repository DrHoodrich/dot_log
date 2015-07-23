<cfset pageTitle="Add User"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/view/header.cfm">
<!-- BEGIN YOUR CONTENT HERE -->
	<!-- TemplateBeginEditable name="main content" -->

<cfoutput><h2>#pageTitle#</h2></cfoutput>

<cffunction name="getUserRegionID" output="true" access="public" returnType="void">
	<cfset regions = "#application.regionService.getAllRegions()#" />
	<cfform name="createUser" action="add_user.cfm" method="post">
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

<cffunction name="getUserDistrictID" output="true" access="public" returnType="void">
	<cfargument name="regionID" type="numeric" required="true" default="" />
	<cfset districts = "#application.districtService.getDistrictsByRegionID(arguments.regionID)#" />
	<cfform name="createUser" action="add_user.cfm" method="post">
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

<cffunction name="getUserHub" output="true" access="public" returnType="void">
	<cfargument name="districtID" type="numeric" required="true" default="" />
	<cfset hubs = "#application.airportService.getHubAirportsByDistrictID(arguments.districtID)#" />
	<cfform name="createUser" action="add_user.cfm" method="post">
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

<cffunction name="getUserDetails" output="true" access="public" returnType="void">
	<cfargument name="hubCode" type="string" required="true" default="" />
	<cfform name="createUser" action="saveUser.cfm" method="post">
		<cfinput type="hidden" name="airportCode" value="#arguments.HubCode#"/>
		<table>
			<tr>
				<td>Username</td>
				<td><cfinput type="text" name="username" message="username" required="yes"/></td>
			</tr>
			<tr>
				<td>First Name</td>
				<td><cfinput type="text" name="firstName" message="First Name" required="yes"/></td>
			</tr>
			<tr>
				<td>Last Name</td>
				<td><cfinput type="text" name="lastName" message="Last Name" required="yes"/></td>
			</tr>
			<tr>
				<td>Email</td>
				<td><cfinput type="text" name="emailAddr" message="Email" validate="email" required="yes"/></td>
			</tr>
			<tr>
				<td>Account Type</td>
				<td>
					<cfselect name="permissions">
						<option value=0>User</option>
						<option value=1>Admin</option>
					</cfselect>
				</td>
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
				<td><cfinput type="submit" name="createUser_button" value="Add User"></td>
			</tr>
		</table>
	</cfform>
</cffunction>

<cfscript>
	if ( !structKeyExists(FORM, "userRegionID")  && !structKeyExists(FORM, "userDistrictID")  && !structKeyExists(FORM, "userHubCode")) {
		getUserRegionID();
	}
	if ( !structKeyExists(FORM, "userDistrictID") && structKeyExists(FORM, "userRegionID") ) {
		getUserDistrictID(FORM.userRegionID);
	}
	if ( !structKeyExists(FORM, "userHubCode") && structKeyExists(FORM, "userDistrictID") ) {
		getUserHub(FORM.userDistrictID);
	}
	if ( structKeyExists(FORM, "userHubCode") ) {
		getUserDetails(FORM.userHubCode);
	}
</cfscript>

	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">