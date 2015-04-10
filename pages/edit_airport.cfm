<cfset pageTitle = "Edit Airport"> <!--- Variable that is used in the html included header --->
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

<cfform name="editAirportForm" action="airport_edit_action.cfm" method="post">
	<cfselect name="faaCode">
		<option value=""> --None-- </option>
			<cfscript>
			  for (ii = 1; ii <= arrayLen(hubAirports); ++ii) {
			    writeOutput('<option value="#hubAirports[ii].getFaaCode()#">#hubAirports[ii].getFaaCode()#  --  #hubAirports[ii].getAirportName()# </option>');
			  }  
		</cfscript>
	</cfselect><br>
  <!--- Parent FAA Code:<cfinput type="text"name = "parentFAACode" message="parentFAACode" required="yes" autoSuggest="#ArrayToList(airportNames)#" typeahead="true" /> <br> --->
    <cfinput type="submit" name="selectAirportToEdit_button" id="listAirports" value="Edit"/>
</cfform>
  <!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="../includes/footer.cfm">