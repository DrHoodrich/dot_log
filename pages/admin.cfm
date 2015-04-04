<cfset pageTitle = "Admin"> <!--- Variable that is used in the html included header --->
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
		user = application.userService.getUserByUsername("us");
	</cfscript>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="../includes/footer.cfm">