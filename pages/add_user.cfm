<cfset pageTitle = "Add User"> <!--- Variable that is used in the html included header --->
<cfinclude template="../includes/header.cfm">
<cfinclude template="../includes/banner.cfm">
	<a id="main_content"></a>
<cfinclude template="../includes/breadcrumb.cfm">
<cfinclude template="../includes/nav.cfm">
    <div id="content">
    
<!-- BEGIN YOUR CONTENT HERE -->
	<!-- TemplateBeginEditable name="main content" -->
<cfoutput><h2>#pageTitle#</h2></cfoutput>
<cfform name="createUser" action="addNewUser_action.cfm" method="post">
	Userame:<cfinput type = "text" name = "username" message = "username" required = "yes"></cfinput> <br>
	First Name:<cfinput type = "text" name = "firstName" message = "First Name" required = "yes"></cfinput> <br>
	Last Name:<cfinput type = "text" name = "lastName" message = "Last Name" required = "yes"></cfinput> <br>
	Email:<cfinput type = "text" name = "emailAddress" message = "Email" required = "yes"></cfinput> <br>
	
	Hub/Region:<cfselect name = "airportID" id = "airportID">
		<option value=1>Fair</option>
		<option value=2>Fairbanks</option>
		<option value=2>Clear</option>
	</cfselect><br>
	Airport:<cfselect name = "userAirport" id = "User Airport">
		<option value=1>some</option>
		<option value=2>other</option>
		<option value=3>airports</option>
	</cfselect><br>
	Account Type:<cfselect name = "permissions" id = "permissions">
		<option value=1>user</option>
		<option value=1337>admin</option>
	</cfselect><br>
	<cfinput type="submit" name="submitUser_button" id="addUser" value="Create User">
</cfform>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="../includes/footer.cfm">