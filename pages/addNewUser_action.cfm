<cfset pageTitle = "Add User"> <!--- Variable that is used in the html included header --->
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
	if ( structKeyExists(FORM, 'createUser_button') ) {		
		FORM.enabled = 1;
		newUser = new dotlog.model.user(argumentCollection=FORM);
		if ( application.userService.saveUser(newUser) ) {
			writeOutput('<h3>New user ' & newUser.getUsername() & ' created Successfully</h3>');
		} else {
			writeOutput('Error creating user ' & newUser.getUsername());
		}
	}
</cfscript>
<cfinclude template="/dotlog/includes/footer.cfm">