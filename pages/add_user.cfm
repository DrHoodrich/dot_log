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
	hubAirports = application.airportService.getChildAirports(session.user.getAirportCode());

	AirportNames = [];
	for (ii = 1; ii <= ArrayLen(hubAirports); ++ii) {
		arrayAppend(airportNames, hubAirports[ii].getAirportCode() & " - " & hubAirports[ii].getAirportName());
	}

</cfscript>
	
<cfform name="createUser" action="addNewUser_action.cfm" method="post">
	Username:<cfinput type = "text" name = "username" message = "username" required = "yes"></cfinput> <br>
	First Name:<cfinput type = "text" name = "firstName" message = "First Name" required = "yes"></cfinput> <br>
	Last Name:<cfinput type = "text" name = "lastName" message = "Last Name" required = "yes"></cfinput> <br>
	Email:<cfinput type = "text" name = "emailAddr" message = "Email" required = "yes"></cfinput> <br>
	
	Location:<cfselect name = "airportCode">
		<option value=""> --None-- </option>
			<cfscript>
			  for (ii = 1; ii <= arrayLen(hubAirports); ++ii) {
			    writeOutput('<option value="#hubAirports[ii].getAirportCode()#">#hubAirports[ii].getAirportCode()#  --  #hubAirports[ii].getAirportName()# </option>');
			  }  
		</cfscript>
	</cfselect><br>
	
	Account Type:<cfselect name = "permissions">
		<option value=1>user</option>
		<option value=2>admin</option>
	</cfselect><br>
	<cfinput type="submit" name="createUser_button" value="Create User">
</cfform>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">