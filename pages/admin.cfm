<cfset pageTitle = "Admin"> <!--- Variable that is used in the html included header --->
<cfinclude template="../includes/header.cfm">
    <a id="main_content"></a>
<cfinclude template="../includes/breadcrumb.cfm">
<cfinclude template="../includes/nav.cfm">
    <div id="content">
    
<!-- BEGIN YOUR CONTENT HERE -->
	<!-- TemplateBeginEditable name="main content" -->
<h2>DOTLog Admin</h2>
<!--- Hard coded until LDAP info. ---> 
	<cfscript>
		user = new dotlog.components.user("joe"); //should be passed in by the login page
		userID = user.getID();
		airports = user.getAirportID();

		cat = new dotlog.components.category();
		possibleCategories = cat.getCategoryNames();
	</cfscript>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="../includes/footer.cfm">