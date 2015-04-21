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
  hubAirports = application.airportService.getChildAirports(session.user.getAirportCode());
</cfscript>
  
<cfform name="createAirportForm" action="add_airport_action.cfm" method="post" >
	Airport Code:<cfinput type = "Text" name = "airportCode" message = "" required = "yes"></cfinput> <br>
  Airport Name:<cfinput type = "Text" name = "airportName" message = "" required = "yes"></cfinput> <br>


  <!---Need a better name :( --->
  Region/Hub Airport:<cfselect name = "parentAirportCode"> 


    <option value=""> --New Hub-- </option>
    <cfscript>
      for (ii = 1; ii <= arrayLen(hubAirports); ++ii) {
        writeOutput('<option value="#hubAirports[ii].getAirportCode()#">#hubAirports[ii].getAirportCode()#</option>');
      }  
    </cfscript>
  </cfselect><br>
	<cfinput type="submit" name="createAirport_button" id="add_airport" value="Create Airport">
</cfform>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">