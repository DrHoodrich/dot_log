<cfset pageTitle = "DOTLog Record Creation">
<cfinclude template="../includes/header.cfm">
<cfinclude template="../includes/banner.cfm">
    <a id="main_content"></a>
<cfinclude template="../includes/breadcrumb.cfm">
<cfinclude template="../includes/nav.cfm">
    <div id="content">

<h2>Category Addition Review</h2>
<cfscript>
	databaseConnector = new dotlog.components.database();
	databaseConnector.addCategory(Form.categoryName);

	categories = new dotlog.components.category();
	categoryNames = categories.getCategoryNames();
	categoryIDs = categories.getCategoryIDs();

	writeOutput('<table width="783" height="180" border="1">');
  	for (ii = 1; ii <= arrayLen(categoryNames); ++ii) {
		writeOutput('<tr> <td width="117" height="102" align="left" valign="top">Category: #categoryNames[ii]# </td>');
  	}
  	writeOutput('</table>');
</cfscript>
<cfinclude template="../includes/footer.cfm">