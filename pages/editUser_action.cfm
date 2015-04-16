<cfset pageTitle = "Edit User"> <!--- Variable that is used in the html included header --->
<cfinclude template="../includes/header.cfm">
<cfinclude template="../includes/banner.cfm">
	<a id="main_content"></a>
<cfinclude template="../includes/breadcrumb.cfm">
<cfinclude template="../includes/nav.cfm">
    <div id="content">
    
<!-- BEGIN YOUR CONTENT HERE -->
	<!-- TemplateBeginEditable name="main content" -->
<cfoutput><h2>#pageTitle#</h2></cfoutput>

<cfif structKeyExists(FORM, 'editUser_button') IS False >
	<cfform name="editUser" action="editUser_action.cfm" method="post">
		<cfselect name="username">
			<option value=""> --None-- </option>
				<cfscript>
				  	if ( structKeyExists(FORM, 'selectAirport_button') ) {
						users = application.userService.getUsersByAirportFAACode(FORM.airportCode);
						if ( arrayLen(users) ) {
							for (ii = 1; ii <= arrayLen(users); ++ii) {
								writeOutput('<option value=#users[ii].getUsername()#>#users[ii].getFullName()#</option>');
							}
						} else {
							writeOutput("<h3>No users at this airport.</h3>");
						}
					} 
				</cfscript>
		</cfselect>
		<br>
		<cfinput type="submit" name="editUser_button" value="Edit User">
	</cfform>
</cfif>

<cfif structKeyExists(FORM, 'editUser_button') IS True>
	<cfscript>
		existingUser = application.userService.getUserByUsername(FORM.username);
	</cfscript>
	<cfform name="editUser" method="post" action="saveUser.cfm">
		<label for="Username">username: <cfoutput><strong>"#existingUser.getUsername()#"</strong></cfoutput></label>
			<cfinput type="hidden" name="Username" value="#existingUser.getUsername()#"> <br>

		<label for="faaCode">airport:</label>
			<cfinput type="text" name="faaCode" value="#existingUser.getAirportFAACode()#"> <br>

		<label for="FirstName">first name:</label>
			<cfinput type="text" name="FirstName" value="#existingUser.getFirstName()#"> <br>

		<label for="LastName">last name:</label>
			<cfinput type="text" name="LastName" value="#existingUser.getLastName()#"> <br>

		<label for="emailAddr">Email:</label>
			<cfinput type="text" name="emailAddr" value="#existingUser.getEmailAddr()#"> <br>

		<label for="Permissions">permissions:</label>
			<cfinput type="text" name="Permissions" value="#existingUser.getPermissions()#"> <br>

		<label for="enabled">Enabled:</label>
			<cfinput type="checkbox" name="enabled" value="#existingUser.isEnabled()#" checked="#existingUser.isEnabled()#" id="enabled"> <br>
		<cfinput type="submit" name="saveUser_button" id="editUser_button" value="Edit">
	</cfform>
</cfif>

<cfinclude template="../includes/footer.cfm">

