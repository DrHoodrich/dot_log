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

<cffunction name="selectCategoryID">
  <cfset categories = #application.categoryService.getAllCategories()#>
  <cfform name="editCategory" action="edit_category.cfm" method="post">
    <table>
      <tr>
        <td>Category</td>
        <td>
          <cfselect name="categoryID">
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

<cffunction name="editCategory">
  <cfset category = #application.categoryService.getCategoryByID(FORM.categoryID)#>
  <cfform name="updateCategory" action="saveCategory.cfm" method="post">
  <cfinput type="hidden" name="categoryID" value="#category.getCategoryID()#"/>
    <table>
      <tr>
        <td>Category Title</td>
        <td><cfinput name="categoryTitle" type="text" value="#category.getCategoryTitle()#"/></td>
      </tr>
      <tr>
        <td>Category Description</td>
        <td><cftextarea name="description" cols="40" rows="5" id="eventDescription" value="#category.getDescription()#"/></td>
      </tr>
      <tr>
        <td>Active</td>
        <td><cfinput type="checkbox" name="enabled" required="no" value="1" checked="#category.isEnabled()#"/></td>
      </tr>
      <tr>
        <td>Included In Weekly Report</td>
        <td><cfinput type="checkbox" name="inWeeklyReport" required="no" value="1" checked="#category.isInWeeklyReport()#"/></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td><cfinput type="submit" name="updateCategory_button" value="Update Category"/></td>
      </tr>
    </table>
  </cfform>
</cffunction>

<cfscript>
  if ( !structKeyExists(FORM, "categoryID") ) {
    selectCategoryID();
  }
  if ( structKeyExists(FORM, "categoryID") ) {
    editCategory();
  }
</cfscript>
  <!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">