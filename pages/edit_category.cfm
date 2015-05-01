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
	allCategories = application.categoryService.getAllCategories();
</cfscript>
  
<cfform name="search" action="updateCategory.cfm" method="post">
  Category to Edit:<cfselect name="categoryTitle" id="categoryTitle">
    <cfscript>
          writeOutput('<option value="none"></option>');
          for (ii = 1; ii <= arrayLen(allCategories); ++ii) {
            writeOutput('<option value=#allCategories[ii].getCategoryTitle()#>#allCategories[ii].getCategoryTitle()#</option>');
          }
    </cfscript>
  </cfselect><br>
  <cfinput type="submit" name="selectCategory_button" id="searchRecords" value="Edit"></cfinput>
</cfform>
  <!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">