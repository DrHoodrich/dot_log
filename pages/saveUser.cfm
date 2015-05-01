<cfset pageTitle = "User Added"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/includes/header.cfm">
<cfinclude template="/dotlog/includes/banner.cfm">
  <a id="main_content"></a>
<cfinclude template="/dotlog/includes/breadcrumb.cfm">
<cfinclude template="/dotlog/includes/nav.cfm">
    <div id="content">
    
<!-- BEGIN YOUR CONTENT HERE -->
  <!-- TemplateBeginEditable name="main content" -->
<cfscript>
	if ( structKeyExists(FORM, 'createUser_button') ) {
		FORM.enabled = 1;
		newUser = new dotlog.model.beans.user(argumentCollection=FORM);
		if ( application.userService.saveUser(newUser) ) {
			writeOutput('<h2>New user "' & newUser.getUsername() & '" Added</h2>');
		} else {
			writeOutput('Error creating user ' & newUser.getUsername());
		}
	}

	if ( structKeyExists(FORM,"updateUser_button") ) {
		user =  new dotlog.model.beans.user(argumentCollection=FORM);
		if ( application.userService.saveUser(user) ) {
			writeOutput("<h2>Updated User: " & user.getUsername()& "</h2>");
		} else {
			writeOutput("<h2>Failed to update user</h2>");
		}
	}
</cfscript>

  <!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">