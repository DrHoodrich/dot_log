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
	statewide = application.airportService.getAirportByAirportCode("Statewide");
	regionAirports = application.airportService.getChildAirports("Statewide");
	hubAirports = [];
	for (ii = 1; ii <= arrayLen(regionAirports); ++ii) {
		arrayAppend(hubAirports, application.airportService.getChildAirports(regionAirports[ii].getAirportCode()));
	}
</cfscript>

<cfform name="createUser" action="saveUser.cfm" method="post">
<table>
	<tr>
		<td>LDAP User</td>
		<td><cfinput type = "text" name = "username" message = "username" required = "yes"/></td>
	</tr>
	<tr>
		<td>First Name</td>
		<td><cfinput type = "text" name = "firstName" message = "First Name" required = "yes"/></td>
	</tr>		
	<tr>
		<td>Last Name</td>
		<td><cfinput type = "text" name = "lastName" message = "Last Name" required = "yes"/></td>
	</tr>
	<tr>
		<td>Email</td>
		<td><cfinput type = "text" name = "emailAddr" message = "Email" validate="email" required = "yes"/></td>
	</tr>
	<tr>
		<td>Assign to</td>
		<td>
				<cfselect name = "parentAirportCode">
					<option value=""> --Select Region/Hub-- </option>
					<cfscript>
						writeOutput('<option style="font-weight:bold;" value="Statewide"><strong>AK Statewide</strong></option>');
						for (ii = 1; ii <= arrayLen(regionAirports); ++ii) {
							writeOutput('<option></option>');
				    		writeOutput('<option value="#regionAirports[ii].getAirportCode()#">--#regionAirports[ii].getAirportName()#--</option>');
				    		tmpArray = hubAirports[ii];
				    		for (md = 1; md <= arrayLen(tmpArray); ++md) {
				    			writeOutput('<option value="#hubAirports[ii][md].getAirportCode()#">#hubAirports[ii][md].getAirportCode()#  --  #hubAirports[ii][md].getAirportName()# </option>');
				  			}
				  		}   
					</cfscript>
				</cfselect>
			</td>
	</tr>
	<tr>
		<td>Account Type</td>
		<td>
			<cfselect name = "permissions">
				<option value=0>User</option>
				<option value=1>Admin</option>
			</cfselect>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><cfinput type="submit" name="createUser_button" value="Add User"></td>
	</tr>
</table>
</cfform>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">