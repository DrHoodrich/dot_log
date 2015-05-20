<cfset pageTitle = "Edit Region"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/includes/header.cfm">
<cfinclude template="/dotlog/includes/banner.cfm">
    <a id="main_content"></a>
<cfinclude template="/dotlog/includes/breadcrumb.cfm">
<cfinclude template="/dotlog/includes/nav.cfm">
    <div id="content">
    
<!-- BEGIN YOUR CONTENT HERE -->
	<!-- TemplateBeginEditable name="main content" -->
<cfoutput><h2>#pageTitle#</h2></cfoutput>

<cffunction name="getRegionID">
	<cfset regions = "#application.regionService.getAllRegions()#" />
	<cfform name="editRegion" action="edit_region.cfm" method="post">
		<table>
			<tr>
				<td>Select Region</td>
				<td>
					<cfselect name="regionID">
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

<cffunction name="setRegionValues">
	<cfset region = "#application.regionService.getRegionByID(FORM.regionID)#" />
	<cfform name="editRegion" action="saveRegion.cfm" method="post">
	<cfinput type="hidden" name="regionID" value="#region.getRegionID()#"/>
		<table>
			<tr>
				<td>Region Name</td>
				<td><cfinput type="Text" name="regionName" message="" value="#region.getRegionName()#"/></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><cfinput type="submit" name="editRegion_button" value="Edit Region"/></td>
			</tr>
		</table>
	</cfform>
</cffunction>

<cfscript>
	if ( !structKeyExists(FORM, "regionID") ) {
		getRegionID();
	}	
	if ( structKeyExists(FORM, "regionID") ) {
		setRegionValues();
	}
</cfscript>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">