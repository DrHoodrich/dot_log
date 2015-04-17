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
  category = application.categoryService.getCategoryByTitle(FORM.categoryTitle);
</cfscript>

<cfform name="updateCategory" action="saveCategory.cfm" method="post">
  <cfoutput>Category Title: <strong>"#category.getCategoryTitle()#"</strong></cfoutput><br>
  <cfinput name="categoryTitle" type="hidden" value="#category.getCategoryTitle()#"></cfinput>
  <cftextarea name="description" cols="40" rows="5" id="eventDescription" value="#category.getDescription()#"></cftextarea><br>
  Enabled:<cfinput type="checkbox" name="enabled" required="no" value="1" checked="#category.isEnabled()#"></cfinput> <br>
   Default Include In Weekly Report:<cfinput type="checkbox" name="inWeeklyReport" required="no" value="1" checked="#category.isInWeeklyReport()#"></cfinput> <br>
     <cfinput type="submit" name="updateCategory_button" value="Update Category"></cfinput>
</cfform>
  <!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">