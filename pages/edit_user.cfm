<cfset pageTitle = "Edit User"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/includes/header.cfm">
<cfinclude template="/dotlog/includes/banner.cfm">
	<a id="main_content"></a>
<cfinclude template="/dotlog/includes/breadcrumb.cfm">
<cfinclude template="/dotlog/includes/nav.cfm">
    <div id="content">

<cfoutput><h2>#pageTitle#</h2></cfoutput>
<cfform name="editUser" action="editUser_action.cfm" method="post">
<!---	Username:<cfinput type = "text" name = "username" message = "username" required = "no"></cfinput> <br> --->
	
	<cfoutput>Select user's airport:</cfoutput>
	<cfselect name="airportCode">
			<cfscript>
				airports = application.airportService.getChildAirports(session.user.getAirportCode());
				writeOutput('<option value="none"></option>');
				for (ii = 1; ii <= arrayLen(airports); ++ii) {
					writeOutput('<option value=#airports[ii].getAirportCode()#>#airports[ii].getAirportName()#</option>');
				}
			</cfscript>
	</cfselect>
	<br>
	<cfinput type="submit" name="selectAirport_button" value="Edit">
</cfform>

<cfinclude template="/dotlog/includes/footer.cfm">