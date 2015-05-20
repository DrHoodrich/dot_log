<cfset pageTitle = "Save District"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/includes/header.cfm">
<cfinclude template="/dotlog/includes/banner.cfm">
  <a id="main_content"></a>
<cfinclude template="/dotlog/includes/breadcrumb.cfm">
<cfinclude template="/dotlog/includes/nav.cfm">
    <div id="content">
<cfscript>

	if ( structKeyExists(FORM, 'createDistrict_button') ) {
		FORM.enabled = 1;	
	} else if ( structKeyExists(FORM, 'editDistrict_button') ) {
		if ( !structKeyExists(FORM,"enabled") ) {
			FORM.enabled = 0;
		}
	}
	district = new dotlog.model.beans.district(argumentCollection = FORM);

	if ( application.districtService.saveDistrict(district) ) {
		writeOutput("<h3>Saved district " & district.getDistrictName() & "</h3>");
	} else {
		writeOutput("<h3>Failed to save district " & district.getDistrictName() & "</h3>");
	}
</cfscript>
<cfinclude template="/dotlog/includes/footer.cfm">