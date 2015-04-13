<cfset pageTitle = "Edit Category"> <!--- Variable that is used in the html included header --->
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
  if (!StructKeyExists(FORM, "enabled")) {
    FORM.enabled = 0;
  }
  if (!StructKeyExists(FORM, "inWeeklyReport")) {
    FORM.inWeeklyReport = 0;
  }
  
  category =  new dotlog.components.category(argumentCollection=FORM);
  saved = application.categoryService.saveCategory(category); 
</cfscript>

  <!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="../includes/footer.cfm">