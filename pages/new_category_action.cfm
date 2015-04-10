<cfset pageTitle = "Category Creation"> <!--- Variable that is used in the html included header --->
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
	if ( structKeyExists(FORM, 'newCategory_button') ) {
		if ( !isNull(FORM.categoryTitle) ) {
			FORM.enabled = 1;
			if ( !isNull(FORM.inWeeklyReport) ) {
				FORM.inWeeklyReport = 1;
			} else {
				FORM.inWeeklyReport = 0;
			}

			newCategory = new dotlog.components.category(argumentCollection=FORM);
			application.categoryService.saveCategory(newCategory);			
		} 
	}
</cfscript>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="../includes/footer.cfm">