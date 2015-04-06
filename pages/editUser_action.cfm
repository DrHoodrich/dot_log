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

<cfscript>
	existingUser = "";
	if ( structKeyExists(FORM, 'submitUser_button') ) {
		if( !isNull(FORM.username) ) {
			existingUser = application.userService.getUserByUsername(FORM.username);
		} else if ( !isNull(FORM.faaCode) ){
			existingUser = application.userService.getUsersByAirportFAACode(FORM.faaCode);
		}
	} else if ( structKeyExists(FORM,"editUser_button")) {
		if (structKeyExists(FORM, 'enabled') ) {
			FORM.enabled = 1;
		} else {
			FORM.enabled = 0;
		}

		existingUser = new dotlog.components.user(argumentCollection = FORM);
		application.userService.saveUser(existingUser);
		existingUser = application.userService.getUserByUsername(FORM.username);
	}
	structClear(FORM);
</cfscript>

<cfif structKeyExists(FORM, 'editUser_button') IS False >
	<cfform name="editUser" method="post" action="editUser_action.cfm">
		<label for="Username">username:</label>
			<cfinput type="text" name="Username" value="#existingUser.getUsername()#"> <br>

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
		<cfinput type="submit" name="editUser_button" id="editUser_button" value="Edit">
	</cfform>
</cfif>
<cfinclude template="../includes/footer.cfm">