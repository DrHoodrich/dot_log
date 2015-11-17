<cfset pageTitle = "User Added">
<cfinclude template="/dotlog/view/header.cfm">
<cfscript>
	if ( structKeyExists(FORM, 'createUser_button') ) {
		FORM.enabled = 1;
		newUser = new dotlog.model.beans.user(argumentCollection=FORM);
		if ( application.userService.saveUser(newUser) ) {
			writeOutput('<h2>New User "' & newUser.getUsername() & '" Added</h2>');
		} else {
			writeOutput('Error creating user ' & newUser.getUsername());
		}
	}

	if ( structKeyExists(FORM,"updateUser_button") ) {
		if ( !structKeyExists(FORM, "enabled") ) {
			FORM.enabled = 0;
		}
		user =  new dotlog.model.beans.user(argumentCollection=FORM);

		if ( application.userService.saveUser(user) ) {
			writeOutput("<h2>Updated User: " & user.getUsername()& "</h2>");
		} else {
			writeOutput("<h2>Failed to update user</h2>");
		}
	}
</cfscript>
<cfinclude template="/dotlog/includes/footer.cfm">