<cfset pageTitle = "Add Category"> <!--- Variable that is used in the html included header --->
<cfinclude template="../includes/header.cfm">
  <a id="main_content"></a>
<cfinclude template="../includes/breadcrumb.cfm">
<cfinclude template="../includes/nav.cfm">
    <div id="content">

<!-- BEGIN YOUR CONTENT HERE -->
	<!-- TemplateBeginEditable name="main content" -->
<cfoutput><h2>#pageTitle#</h2></cfoutput>
<cfform name="recordCreation" method="post" action="admin_action.cfm">
  <label for="categoryName">Category Title:</label>
	   <cfinput type = "text" name = "categoryName" message = "Category Name is Required" required = "yes"></cfinput> <br>
	<cfinput type="submit" name="add_user" id="add_user" value="Submit">
</cfform>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="../includes/footer.cfm">