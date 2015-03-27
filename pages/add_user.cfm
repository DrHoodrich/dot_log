<cfset pageTitle = "DOTLog Add User"> <!--- Variable that is used in the html included header --->
<cfinclude template="../includes/header.cfm">
<cfinclude template="../includes/banner.cfm">
	<a id="main_content"></a>
<cfinclude template="../includes/breadcrumb.cfm">
<cfinclude template="../includes/nav.cfm">
    <div id="content">
    
<!-- BEGIN YOUR CONTENT HERE -->
	<!-- TemplateBeginEditable name="main content" -->
<cfoutput><h2>#pageTitle#</h2></cfoutput>
<cfform>
	User Name:<cfinput type = "text" name = "userName" message = "User Name" required = "yes"></cfinput> <br>
	User Initials:<cfinput type = "text" name = "userInitials" message = "User Initials" required = "yes"></cfinput> <br>
	Hub/Region:<cfselect name = "userHub" id = "userHub">
		<option value="#possibleCategories[ii]#">Fairbanks</option>
		<option value="#possibleCategories[ii]#">Fairbanks</option>
		<option value="#possibleCategories[ii]#">Fairbanks</option>
	</cfselect><br>
	Airport:<cfselect name = "userAirport" id = "User Airport">
		<option value="#possibleCategories[ii]#">Fairbanks</option>
		<option value="#possibleCategories[ii]#">Fairbanks</option>
		<option value="#possibleCategories[ii]#">Fairbanks</option>
	</cfselect><br>
	Account Type:<cfselect name = "userType" id = "User Type">
		<option value="#possibleCategories[ii]#">Bearded Admin</option>
		<option value="#possibleCategories[ii]#">Talvinator</option>
	</cfselect><br>
	<cfinput type="submit" name="addUser" id="addUser" value="Submit">
</cfform>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="../includes/footer.cfm">