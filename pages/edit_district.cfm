<cfset pageTitle = "Edit District"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/view/header.cfm">
<cfoutput><h2>#pageTitle#</h2></cfoutput>

<cffunction name="getDistrictRegionID">
	<cfset regions = "#application.regionService.getAllRegions()#" />
	<cfform name="editDistrict" action="edit_district.cfm" method="post">
		<table>
			<tr>
				<td>District's Region</td>
				<td>
					<cfselect name="districtRegionID">
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

<cffunction name="selectDistrict">
	<cfset districts = "#application.districtService.getDistrictsByRegionID(FORM.districtRegionID)#" />
	<cfform name="editDistrict" action="edit_district.cfm" method="post">
		<cfinput type="hidden" name="regionID" value="#FORM.districtRegionID#"/>
		<table>			
			<tr>
				<td>District</td>
				<td>
					<cfselect name="districtID">
						<option value="-1"/>--District--</option>
						<cfloop index="district" array="#districts#">
							<cfoutput><option value="#district.getDistrictID()#">#district.getDistrictName()#</cfoutput>
						</cfloop>
					</cfselect>
				</td>
			</tr>			
			<tr>
				<td>&nbsp;</td>
				<td><cfinput type="submit" name="selectDistrict_button" value="Edit District"/></td>
			</tr>
		</table>
	</cfform>
</cffunction>

<cffunction name="setDistrictValues">
	<cfset district = "#application.districtService.getDistrictByID(FORM.districtID)#" />
	<cfform name="editDistrict" action="saveDistrict.cfm" method="post">
	<cfinput type="hidden" name="districtID" value="#district.getDistrictID()#"/>
	<cfinput type="hidden" name="regionID" value="#district.getRegionID()#"/>
		<table>
			<tr>
				<td>District Name</td>
				<td><cfinput type="Text" name="districtName" message="" value="#district.getDistrictName()#"/></td>
			</tr>
			<tr>
        		<td>Active</td>
        		<td><cfinput type="checkbox" name="enabled" value="#district.isEnabled()#" checked="#district.isEnabled()#"/></td>
      		</tr>	
			<tr>
				<td>&nbsp;</td>
				<td><cfinput type="submit" name="editDistrict_button" value="Edit District"/></td>
			</tr>
		</table>
	</cfform>
</cffunction>

<cfscript>
	if ( !structKeyExists(FORM, "districtRegionID") && !structKeyExists(FORM, "districtID") ) {
		getDistrictRegionID();
	}	
	if ( structKeyExists(FORM, "districtRegionID") ) {
		selectDistrict();
	}
	if ( structKeyExists(FORM, "districtID") ) {
		setDistrictValues();
	}
</cfscript>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">