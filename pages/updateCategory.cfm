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
	<cfinput type="hidden" name="recordID" value="#category.getCategoryID()#"/>
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
<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">