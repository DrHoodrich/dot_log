<cfset pageTitle = "Add District"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/includes/header.cfm">
<cfinclude template="/dotlog/includes/banner.cfm">
    <a id="main_content"></a>
<cfinclude template="/dotlog/includes/breadcrumb.cfm">
<cfinclude template="/dotlog/includes/nav.cfm">
    <div id="content">
    
<!-- BEGIN YOUR CONTENT HERE -->
	<!-- TemplateBeginEditable name="main content" -->
<cfoutput><h2>#pageTitle#</h2></cfoutput>

<cffunction name="getDistrictRegionID">
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

<cffunction name="setDistrictValues">
	<cfform name="createDistrict" action="saveDistrict.cfm" method="post">
		<cfinput type="hidden" name="regionID" value="#FORM.districtRegionID#"/>
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
		setDistrictValues();
	}	
</cfscript>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">