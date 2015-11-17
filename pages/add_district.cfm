<cfset pageTitle = "Add District"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/view/header.cfm">

<cfoutput><h2>#pageTitle#</h2></cfoutput>

<cffunction name="getDistrictRegionID" output="true" access="public" returnType="void">
	<cfset regions = "#application.regionService.getAllRegions()#" />
	<cfform name="createDistrict" action="add_district.cfm" method="post">
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

<cffunction name="setDistrictValues" output="true" access="public" returnType="void">
	<cfargument name="regionID" type="numeric" required="true" default="" />
	<cfform name="createDistrict" action="saveDistrict.cfm" method="post">
		<cfinput type="hidden" name="regionID" value="#arguments.regionID#"/>
		<cfinput type="hidden" name="enabled" value="1"/>
		<table>
			<tr>
				<td>District Name</td>
				<td><cfinput type="Text" name="districtName" message=""/></td>
			</tr>			
			<tr>
				<td>&nbsp;</td>
				<td><cfinput type="submit" name="createDistrict_button" value="Create District"/></td>
			</tr>
		</table>
	</cfform>
</cffunction>

<cfscript>
	if ( !structKeyExists(FORM, "districtRegionID") ) {
		getDistrictRegionID();
	}	
	if ( structKeyExists(FORM, "districtRegionID") ) {
		setDistrictValues(FORM.districtRegionID);
	}	
</cfscript>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">