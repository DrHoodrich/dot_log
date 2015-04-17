<cfset pageTitle = "DOTLog Login Action">
<cfinclude template="/dotlog/includes/header.cfm">
<cfinclude template="/dotlog/includes/banner.cfm">
    <a id="main_content"></a>
<cfinclude template="/dotlog/includes/breadcrumb.cfm">
<cfinclude template="/dotlog/includes/nav.cfm">
    <div id="content">

<cfoutput><h2>#pageTitle#</h2></cfoutput>

<!--- <cfdump
var="#APPLICATION.GetApplicationSettings()#"
label="GetApplicationSettings() Output"
/> --->

<!--- <cfdump var="#CGI#"/> --->

<cfscript>
	Session.databaseConnector = new dotlog.components.database();
	Session.user = new dotlog.components.user(#Form.userName#);

	//databaseConnector.addCategory(Form.categoryName);

	//categories = new dotlog.components.category();
	//categoryNames = categories.getCategoryNames();
	//categoryIDs = categories.getCategoryIDs();

/*
	writeOutput('<table width="783" height="180" border="1">');
  	for (ii = 1; ii <= arrayLen(categoryNames); ++ii) {
		writeOutput('<tr> <td width="117" height="102" align="left" valign="top">Category: #categoryNames[ii]# </td>');
  	}
  	writeOutput('</table>');
*/
</cfscript>
<cfdump var="#SESSION#"/>
<cfinclude template="/dotlog/includes/footer.cfm">