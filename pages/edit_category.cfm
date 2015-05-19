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

<cffunction name="selectCategoryTitle">
  <cfset categories = #application.categoryService.getAllCategories()#>
  <cfform name="editCategory" action="updateCategory.cfm" method="post">
    <table>
      <tr>
        <td>Category</td>
        <td>
          <cfselect name="categoryTitle">
            <option value="-1"/>--Category--</option>
            <cfloop index="category" array="#categories#">
              <cfoutput><option value="#category.getCategoryID()#">#category.getCategoryTitle()#</cfoutput>
            </cfloop>
          </cfselect>
        </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td><cfinput type="submit" name="selectCategory_button" value="Select"></cfinput></td>
      </tr>
    </table>
  </cfform>
</cffunction>

<cfscript>
  if ( !structKeyExists(FORM, "categoryTitle") ) {
    selectCategoryTitle();
  }
</cfscript>
  <!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">