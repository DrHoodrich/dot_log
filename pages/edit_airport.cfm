<cfset pageTitle = "Edit Airport"> <!--- Variable that is used in the html included header --->
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
  user = application.userService.getUserByUsername("us");
  hubAirports = application.airportService.getChildAirports(session.user.getAirportCode());

	AirportNames = [];
  for (ii = 1; ii <= ArrayLen(hubAirports); ++ii) {
  	arrayAppend(airportNames, hubAirports[ii].getAirportCode() & " - " & hubAirports[ii].getAirportName());
  }
</cfscript>

<cfform name="editAirportForm" action="airport_edit_action.cfm" method="post">
	<cfselect name="airportCode">
		<option value=""> --None-- </option>
			<cfscript>
			  for (ii = 1; ii <= arrayLen(hubAirports); ++ii) {
			    writeOutput('<option value="#hubAirports[ii].getAirportCode()#">#hubAirports[ii].getAirportCode()#  --  #hubAirports[ii].getAirportName()# </option>');
			  }  
		</cfscript>
	</cfselect><br>
  <!--- Parent FAA Code:<cfinput type="text"name = "parentAirportCode" message="parentAirportCode" required="yes" autoSuggest="#ArrayToList(airportNames)#" typeahead="true" /> <br> --->
    <cfinput type="submit" name="selectAirportToEdit_button" id="listAirports" value="Edit"/>
</cfform>
  <!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">