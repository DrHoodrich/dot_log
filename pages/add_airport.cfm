<cfset pageTitle = "Add Airport"> <!--- Variable that is used in the html included header --->
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
  hubAirports = application.airportDAO.getChildAirports(user.getAirportFaaCode());
</cfscript>
  
<cfform name="createAirportForm" action="airport_create_action.cfm" method="post" >
	Airport Code:<cfinput type = "Text" name = "FAAcode" message = "" required = "yes"></cfinput> <br>
  Airport Name:<cfinput type = "Text" name = "airportName" message = "" required = "yes"></cfinput> <br>


  <!---Need a better name :( --->
  Hub/Region:<cfselect name = "parentFAACode"> 


    <option value=""> --New Hub-- </option>
    <cfscript>
      for (ii = 1; ii <= arrayLen(hubAirports); ++ii) {
        writeOutput('<option value="#hubAirports[ii].getFaaCode()#">#hubAirports[ii].getFaaCode()#</option>');
      }  
    </cfscript>
  </cfselect><br>
	<cfinput type="submit" name="createAirport_button" id="add_airport" value="Create Airport">
</cfform>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="../includes/footer.cfm">