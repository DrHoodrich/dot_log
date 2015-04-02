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
	if ( structKeyExists(FORM, 'submitUser_button') ) {
		writeDump(FORM);
		dataSource = new dotlog.components.datasource("DOTlogDB","","");
		userDOA = new dotlog.components.userDAO(dataSource);
		if( isNull(FORM.username) ) {
			existingUser = userDOA.getUserbyUsername(FORM.username);
			writeDump(existingUser);
		} else if ( !isNull(FORM.faaCode) ){
			existingUsers = userDOA.getUsersByAirportFAACode(FORM.faaCode);
			writeDump(existingUsers);
		}
	}
</cfscript>
<cfinclude template="../includes/footer.cfm">