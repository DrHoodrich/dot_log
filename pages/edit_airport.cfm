<cfset pageTitle = "Edit Airport"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/view/header.cfm">

<cfoutput><h2>#pageTitle#</h2></cfoutput>
<cffunction name="getAirportRegionID">
  <cfset regions = "#application.regionService.getAllRegions()#" />
  <cfform name="editAirport" action="edit_airport.cfm" method="post">
    <table>
      <tr>
        <td>Airport's Region</td>
        <td>
          <cfselect name="airportRegionID">
            <option value="-1"/>--Region--</option>
            <cfloop index="region" array="#regions#">
              <cfoutput><option value="#region.getRegionID()#">#region.getRegionName()#</cfoutput>
            </cfloop>
          </cfselect>
        </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td><cfinput type="submit" name="selectRegion_button" value="Select"></td>
      </tr>
    </table>
  </cfform>
</cffunction>

<cffunction name="getAirportDistrictID">
  <cfset districts = "#application.districtService.getDistrictsByRegionID(FORM.airportRegionID)#" />
  <cfform name="editAirport" action="edit_airport.cfm" method="post">
    <table>
      <tr>
        <td>Airport's District</td>
        <td>
          <cfselect name="airportDistrictID">
            <option value="-1"/>--District--</option>
            <cfloop index="district" array="#districts#">
              <cfoutput><option value="#district.getDistrictID()#">#district.getDistrictName()#</cfoutput>
            </cfloop>
          </cfselect>
        </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td><cfinput type="submit" name="selectDistrict_button" value="Select"></td>
      </tr>
    </table>
  </cfform>
</cffunction>

<cffunction name="getAirportHub">
  <cfset hubs = "#application.airportService.getHubAirportsByDistrictID(FORM.airportDistrictID)#" />
  <cfform name="editAirport" action="edit_airport.cfm" method="post">
    <cfinput type="hidden" name="districtID" value="#FORM.airportDistrictID#"/>
    <table>
      <tr>
        <td>Associated Hub</td>
        <td>
          <cfselect name="airportHubCode">
            <option value="-1"/>--Select Hub--</option>
            <cfloop index="hub" array="#hubs#">
              <cfoutput><option value="#hub.getAirportCode()#">#hub.getAirportName()#</cfoutput>
            </cfloop>
          </cfselect>
        </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td><cfinput type="submit" name="selectHub_button" value="Select"></td>
      </tr>
    </table>
  </cfform>
</cffunction>

<cffunction name="getAirport">
  <cfset airports = "#application.airportService.getHubAndSpokesAirports(FORM.airportHubCode)#" />
  <cfform name="editAirport" action="edit_airport.cfm" method="post">
    <cfinput type="hidden" name="districtID" value="#FORM.districtID#"/>
    <cfinput type="hidden" name="enabled" value="1"/>
    <table>
      <tr>
        <td>Select Airport</td>
        <td>
          <cfselect name="airportCode">
            <option value="-1"/>--Select Airport--</option>
            <cfloop index="airport" array="#airports#">
              <cfoutput><option value="#airport.getAirportCode()#">#airport.getAirportCode()# -- #airport.getAirportName()#</cfoutput>
            </cfloop>
          </cfselect>
        </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td><cfinput type="submit" name="selectAirport_button" value="Select"/></td>
      </tr>
    </table>
  </cfform>
</cffunction>

<cffunction name="editAirport">
  <cfset airport = "#application.airportService.getAirportByAirportCode(FORM.airportCode)#">
  <cfform name="editAirport" action="saveAirport.cfm" method="post">
    <cfinput type="hidden" name="districtID" value="#airport.getDistrictID()#"/>
    <table>
      <tr>
        <cfinput type="hidden" name="hubCode" value="#airport.getHubCode()#"/>
        <td>Hub Code</td>
        <td><cfoutput><strong>#airport.getHubCode()#</strong></cfoutput></td>
      </tr>
      <tr>
        <cfinput type="hidden" name="airportCode" value="#airport.getAirportCode()#"/>
        <td>FAA Code</td>
        <td><cfoutput><strong>#airport.getAirportCode()#</strong></cfoutput></td>
      </tr>
      <tr>
        <td>Airport Name</td>
        <td><cfinput type="Text" name="airportName" value="#airport.getAirportName()#"/></td>
      </tr>
      <tr>
        <td>Active</td>
        <td><cfinput type="checkbox" name="enabled" value="#airport.isEnabled()#" checked="#airport.isEnabled()#"/></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td><cfinput type="submit" name="editAirport_button" value="Edit Airport"/></td>
      </tr>
    </table>
  </cfform>
</cffunction>
 
<cfscript>
writeDump(FORM);
  if ( !structKeyExists(FORM, "airportRegionID")  && !structKeyExists(FORM, "airportDistrictID")  && !structKeyExists(FORM, "airportHubCode") && !structKeyExists(FORM, "airportCode") ) {
    getAirportRegionID();
  }
  if ( !structKeyExists(FORM, "airportDistrictID") && structKeyExists(FORM, "airportRegionID") ) {
    getAirportDistrictID();
  }
  if ( !structKeyExists(FORM, "airportHubCode") && structKeyExists(FORM, "airportDistrictID") ) {
    getAirportHub();
  }
  if ( structKeyExists(FORM, "airportHubCode") && FORM.airportHubCode == -1 ) {
    setHubAirportValues();
  }
  if ( structKeyExists(FORM, "airportHubCode") && FORM.airportHubCode > 0) {
    getAirport();
  }
  if ( structKeyExists(FORM, "airportCode") ) {
    editAirport();
  }
</cfscript>
<cfinclude template="/dotlog/includes/footer.cfm">