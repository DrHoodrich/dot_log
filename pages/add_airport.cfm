<cfset pageTitle = "Add Airport"> <!--- Variable that is used in the html included header --->
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
	function getAirportChildren(required string airportCode)
	{
		
	}
</cfscript>

<cfscript>
	statewide = application.airportService.getAirportByAirportCode("Statewide");
	regionAirports = application.airportService.getChildAirports("Statewide");
	hubAirports = [];
	for (ii = 1; ii <= arrayLen(regionAirports); ++ii) {
		arrayAppend(hubAirports, application.airportService.getChildAirports(regionAirports[ii].getAirportCode()));
	}
</cfscript>
  
<cfform name="createAirportForm" action="saveAirport.cfm" method="post">
	<table>
		<tr>
			<td>Airport Name</td>
			<td><cfinput type="Text" name="airportName" message=""/></td>
		</tr>
		<tr>
			<td>FAA Code</td>
			<td><cfinput type="Text" name="airportCode" message=""/></td>
		</tr>
		<tr>
			<td>Assign To</td>
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
			<td>&nbsp;</td>
			<td><cfinput type="submit" name="createAirport_button" id="add_airport" value="Add Airport"/></td>
		</tr>
	</table>
</cfform>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">