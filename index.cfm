<cfset pageTitle = "Index">
<cfinclude template="/dotlog/view/header.cfm">	
<cfoutput><h2>#pageTitle#</h2></cfoutput>
<cfif session.user.getPermissions() IS FALSE>
	<cflocation url="/dotlog/pages/add_event.cfm">
</cfif>

<cfoutput><h2>Welcome to the Index page, nothing to see here...</h2></cfoutput>


<cfinclude template="/dotlog/includes/footer.cfm">
