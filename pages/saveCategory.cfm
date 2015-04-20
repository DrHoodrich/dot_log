<cfset pageTitle = "Edit Category"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/includes/header.cfm">
<cfinclude template="/dotlog/includes/banner.cfm">
  <a id="main_content"></a>
<cfinclude template="/dotlog/includes/breadcrumb.cfm">
<cfinclude template="/dotlog/includes/nav.cfm">
    <div id="content">
    
<!-- BEGIN YOUR CONTENT HERE -->
  <!-- TemplateBeginEditable name="main content" -->
<cfoutput><h2>#pageTitle#</h2></cfoutput>

<cfscript>
  if (!StructKeyExists(FORM, "enabled")) {
    FORM.enabled = 0;
  }
  if (!StructKeyExists(FORM, "inWeeklyReport")) {
    FORM.inWeeklyReport = 0;
  }
  
  category =  new dotlog.model.category(argumentCollection=FORM);
  if ( application.categoryService.saveCategory(category) ) {
    writeOutput("<h3>Saved Category</h3>");
  } else {
    writeOutput("<h3>Failed to save category</h3>");
  }
</cfscript>

  <!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">