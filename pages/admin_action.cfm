<cfset pageTitle = "Category Addition Review">
<cfinclude template="../includes/header.cfm">
<cfinclude template="../includes/banner.cfm">
    <a id="main_content"></a>
<cfinclude template="../includes/breadcrumb.cfm">
<cfinclude template="../includes/nav.cfm">
    <div id="content">

<cfoutput><h2>#pageTitle#</h2></cfoutput>
<cfscript>
	databaseConnector = new dotlog.components.database();
	databaseConnector.addCategory(Form.categoryTitle);

	categories = new dotlog.components.category();
	category_titles = categories.getCategoryTitles();
	category_descriptions = categories.getCategoryDescriptions();

	writeOutput('<table width="783" height="180" border="1">');
  	for (ii = 1; ii <= arrayLen(category_titles); ++ii) {
		writeOutput('<tr> <td width="50" height="102" align="left" valign="top">Category: #category_titles[ii]# </td>');
		writeOutput('<td width="117" height="102" align="left" valign="top">Description: #category_descriptions[ii]# </td>');
  	}
  	writeOutput('</table>');
</cfscript>
<cfinclude template="../includes/footer.cfm">