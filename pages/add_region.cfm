<cfset pageTitle = "Add Region"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/includes/header.cfm">
<cfinclude template="/dotlog/includes/banner.cfm">
    <a id="main_content"></a>
<cfinclude template="/dotlog/includes/breadcrumb.cfm">
<cfinclude template="/dotlog/includes/nav.cfm">
    <div id="content">
    
<!-- BEGIN YOUR CONTENT HERE -->
	<!-- TemplateBeginEditable name="main content" -->
<cfoutput><h2>#pageTitle#</h2></cfoutput>


<cffunction name="setRegionValues" output="true" access="public" returnType="void">
	<cfform name="createRegion" action="saveRegion.cfm" method="post">
		<cfinput type="hidden" name="enabled" value="1"/>
		<table>
			<tr>
				<td>Region Name</td>
				<td><cfinput type="Text" name="regionName" message=""/></td>
			</tr>			
			<tr>
				<td>&nbsp;</td>
				<td><cfinput type="submit" name="createRegion_button" value="Create Region"/></td>
			</tr>
		</table>
	</cfform>
</cffunction>

<cfscript>
	if ( !structKeyExists(FORM, "regionName") ) {
		setRegionValues();
	}	
</cfscript>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">