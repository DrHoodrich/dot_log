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
<cfscript>
	user = application.userService.getUserByUsername("us");

	hubAirports = application.airportService.getChildAirports(user.getAirportFaaCode());

	AirportNames = [];
  for (ii = 1; ii <= ArrayLen(hubAirports); ++ii) {
  	arrayAppend(airportNames, hubAirports[ii].getFaaCode() & " - " & hubAirports[ii].getAirportName());
  }

</cfscript>
	
<cfform name="createUser" action="addNewUser_action.cfm" method="post">
	Userame:<cfinput type = "text" name = "username" message = "username" required = "yes"></cfinput> <br>
	First Name:<cfinput type = "text" name = "firstName" message = "First Name" required = "yes"></cfinput> <br>
	Last Name:<cfinput type = "text" name = "lastName" message = "Last Name" required = "yes"></cfinput> <br>
	Email:<cfinput type = "text" name = "emailAddr" message = "Email" required = "yes"></cfinput> <br>
	
	Location:<cfselect name = "faaCode">
		<option value=""> --None-- </option>
			<cfscript>
			  for (ii = 1; ii <= arrayLen(hubAirports); ++ii) {
			    writeOutput('<option value="#hubAirports[ii].getFaaCode()#">#hubAirports[ii].getFaaCode()#  --  #hubAirports[ii].getAirportName()# </option>');
			  }  
		</cfscript>
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