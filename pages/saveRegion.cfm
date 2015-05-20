<cfset pageTitle = "Save Region"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/includes/header.cfm">
<cfinclude template="/dotlog/includes/banner.cfm">
  <a id="main_content"></a>
<cfinclude template="/dotlog/includes/breadcrumb.cfm">
<cfinclude template="/dotlog/includes/nav.cfm">
    <div id="content">
<cfscript>

	if ( structKeyExists(FORM, 'createRegion_button') ) {
		FORM.enabled = 1;	
	} else if ( structKeyExists(FORM, 'editRegion_button') ) {
		if ( !structKeyExists(FORM,"enabled") ) {
			FORM.enabled = 0;
		}
	}
	region = new dotlog.model.beans.region(argumentCollection = FORM);

	if ( application.regionService.saveRegion(region) ) {
		writeOutput("<h3>Saved region " & region.getRegionName() & "</h3>");
	} else {
		writeOutput("<h3>Failed to save region " & region.getRegionName() & "</h3>");
	}
</cfscript>
<cfinclude template="/dotlog/includes/footer.cfm">