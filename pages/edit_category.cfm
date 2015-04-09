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
	dataSource = new dotlog.components.datasource("DOTlogDB","","");
	categoryDOA = new dotlog.components.categoryDAO(dataSource);
	allCategories = categoryDOA.getAllCategories();
</cfscript>


  
<cfform>
  Category to edit:<cfselect name="oldCategoryTitle" id="categoryTitle">
    <cfscript>
          writeOutput('<option value="none"></option>');
          for (ii = 1; ii <= arrayLen(allCategories); ++ii) {
            writeOutput('<option value=#allCategories[ii].getCategoryTitle()#>#allCategories[ii].getCategoryTitle()#</option>');
          }
    </cfscript>
  </cfselect>
</cfform>


<cfform name="search" action="category_edit_action.cfm" method="post">
  New Category Title:<cfinput type="text" name = "username" message="username" required="yes"></cfinput> <br>
  Category Description:<cfinput type="text" name="faaCode" message="faaCode" required="no"></cfinput> <br>
  In Weekly Report:<cfinput type="checkbox" name="inWeeklyReport" required="no"></cfinput> <br>
  <cfinput type="submit" name="submitSearch_button" id="searchRecords" value="search"></cfinput>
</cfform>
  <!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="../includes/footer.cfm">