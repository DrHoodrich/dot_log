<cfset pageTitle = "Index"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/includes/header.cfm">
<cfinclude template="/dotlog/includes/banner.cfm">
	<a id="main_content"></a>
<cfinclude template="/dotlog/includes/breadcrumb.cfm">
<cfinclude template="/dotlog/includes/nav.cfm">
    <div id="content">
    
<!-- BEGIN YOUR CONTENT HERE -->
	<!-- TemplateBeginEditable name="main content" -->
<cfoutput><h2>#pageTitle#</h2></cfoutput>
<cfif session.user.getPermissions() IS FALSE>
	<cflocation url="/dotlog/pages/add_event.cfm">
</cfif>

<cfoutput><h2>Welcome to the Index page, nothing to see here...</h2></cfoutput>


<cfinclude template="/dotlog/includes/footer.cfm">
