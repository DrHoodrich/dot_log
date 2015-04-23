<cfset pageTitle = "Edit User"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/includes/header.cfm">
<cfinclude template="/dotlog/includes/banner.cfm">
	<a id="main_content"></a>
<cfinclude template="/dotlog/includes/breadcrumb.cfm">
<cfinclude template="/dotlog/includes/nav.cfm">
    <div id="content">

<cfoutput><h2>#pageTitle#</h2></cfoutput>
<cfscript>
	statewide = application.airportService.getAirportByAirportCode("Statewide");
	regionAirports = application.airportService.getChildAirports("Statewide");
	hubAirports = [];
	for (ii = 1; ii <= arrayLen(regionAirports); ++ii) {
		arrayAppend(hubAirports, application.airportService.getChildAirports(regionAirports[ii].getAirportCode()));
	}
</cfscript>

<cfform name="editUser" action="edit_user_action.cfm" method="post">
	
	<cfoutput>Select user's Region/Hub:</cfoutput>
				<cfselect name = "AirportCode">
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
	<br>
	<cfinput type="submit" name="selectAirport_button" value="Select Hub">
</cfform>

<cfinclude template="/dotlog/includes/footer.cfm">