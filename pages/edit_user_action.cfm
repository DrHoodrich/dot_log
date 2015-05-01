<cfset pageTitle = "Edit User"> <!--- Variable that is used in the html included header --->
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
	statewide = application.airportService.getAirportByAirportCode("Statewide");
	regionAirports = application.airportService.getChildAirports("Statewide");
	hubAirports = [];
	for (ii = 1; ii <= arrayLen(regionAirports); ++ii) {
		arrayAppend(hubAirports, application.airportService.getChildAirports(regionAirports[ii].getAirportCode()));
	}
</cfscript>


<cfif structKeyExists(FORM, 'selectAirport_button') IS True >
	<cfform name="editUser" action="edit_user_action.cfm" method="post">
		<cfselect name="username">
			<option value=""> --None-- </option>
				<cfscript>
				  	if ( structKeyExists(FORM, 'selectAirport_button') ) {
						users = application.userService.getUsersByAirportCode(FORM.airportCode);
						if ( arrayLen(users) ) {
							for (ii = 1; ii <= arrayLen(users); ++ii) {
								writeOutput('<option value=#users[ii].getUsername()#>#users[ii].getFullName()&' - '&users[ii].getUsername()#</option>');
							}
						} else {
							writeOutput("<h3>No users at this airport.</h3>");
						}
					} 
				</cfscript>
		</cfselect>
		<br>
		<cfinput type="submit" name="editUser_button" value="Select User">
	</cfform>
</cfif>

<cfif structKeyExists(FORM, 'editUser_button') IS True>
	<cfscript>
		existingUser = application.userService.getUserByUsername(FORM.username);
		accountType = "User";
		if (existingUser.getPermissions()) {
			accountType = "Admin";
		}

		statewide = application.airportService.getAirportByAirportCode("Statewide");
		regionAirports = application.airportService.getChildAirports("Statewide");
		hubAirports = [];
		for (ii = 1; ii <= arrayLen(regionAirports); ++ii) {
			arrayAppend(hubAirports, application.airportService.getChildAirports(regionAirports[ii].getAirportCode()));
		}
	</cfscript>
	<cfform name="editUser" method="post" action="saveUser.cfm">
		
	<table>
		<tr>
			<td>LDAP User</td>
			<td><cfoutput><strong>"#existingUser.getUsername()#"</strong></cfoutput></td>
			<cfinput type="hidden" name="username" value="#existingUser.getUsername()#"/>
		</tr>
		<tr>
			<td>First Name</td>
			<td><cfinput type="text" name="firstName" value="#existingUser.getFirstName()#"/></td>
		</tr>		
		<tr>
			<td>Last Name</td>
			<td><cfinput type="text" name="lastName" value="#existingUser.getLastName()#"></td>
		</tr>
		<tr>
			<td>Email</td>
			<td><cfinput type="text" name="emailAddr" value="#existingUser.getEmailAddr()#"></td>
		</tr>
		<tr>
			<td>Region/Hub</td>
			<td>
				<cfselect name = "airportCode">
					
					<cfscript>
					writeOutput('<option value="#existingUser.getAirportCode()#">#existingUser.getAirportCode()#</option>');
					
						writeOutput('<option style="font-weight:bold;" value="Statewide"><strong>AK Statewide</strong></option>');
						for (ii = 1; ii <= arrayLen(regionAirports); ++ii) {
							writeOutput('<option></option>');
				    		writeOutput('<option value="#regionAirports[ii].getAirportCode()#">--#regionAirports[ii].getAirportName()#--</option>');
				    		tmpArray = hubAirports[ii];
				    		for (md = 1; md <= arrayLen(tmpArray); ++md) {
				    			writeOutput('<option value="#hubAirports[ii][md].getAirportCode()#">#hubAirports[ii][md].getAirportCode()#  --  #hubAirports[ii][md].getAirportName()# </option>');
				  			}
				  		}   
					</cfscript>
				</cfselect>
			</td>
		</tr>
		<tr>
			<td>Account Type</td>
			<td>
				<cfselect name = "permissions">
					<cfoutput><option value="#existingUser.getPermissions()#">#accountType#</cfoutput>
					<option value=0>User</option>
					<option value=1>Admin</option>
				</cfselect>
			</td>
		</tr>
		<tr>
			<td>Active</td>
			<td><cfinput type="checkbox" name="enabled" value="#existingUser.isEnabled()#" checked="#existingUser.isEnabled()#" id="enabled"/></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td><cfinput type="submit" name="updateUser_button" value="Update User"></td>
		</tr>
	</table>
	</cfform>
</cfif>

<cfinclude template="/dotlog/includes/footer.cfm">

