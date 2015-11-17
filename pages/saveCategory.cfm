<cfset pageTitle = "Save Category"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/view/header.cfm">
    
<!-- BEGIN YOUR CONTENT HERE -->
  <!-- TemplateBeginEditable name="main content" -->

<cfscript>
	category = '';
	if ( structKeyExists(FORM, 'addCategory_button') ) {
		if ( !isNull(FORM.categoryTitle) ) {
			FORM.enabled = 1;
			if ( !isNull(FORM.inWeeklyReport) ) {
				FORM.inWeeklyReport = 1;
			} else {
				FORM.inWeeklyReport = 0;
			}			
		} 
	} else if ( structKeyExists(FORM,"updateCategory_button") ) {
		if ( !StructKeyExists(FORM, "enabled") ) {
			FORM.enabled = 0;
		}
		if (!StructKeyExists(FORM, "inWeeklyReport")) {
			FORM.inWeeklyReport = 0;
		}
	}

	category = new dotlog.model.beans.category(argumentCollection=FORM);

	if ( application.categoryService.saveCategory(category) ) {
	    writeOutput("<h2>Saved Category</h2>");
	} else {
	    writeOutput("<h2>Failed to save category</h2>");
	}
</cfscript>

  <!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">