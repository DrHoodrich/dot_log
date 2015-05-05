<cfset pageTitle = "Categories"> <!--- Variable that is used in the html included header --->
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
    categories = application.categoryService.getEnabledCategories();
    
    writeOutput('<table frame="none">');
    writeOutput('<thead><tr><th><h3>Title</h3></th><th></th><th><h3>Description</h3></th></tr>');
    writeOutput('<tbody>');
    for (ii = 1; ii <= arrayLen(categories); ++ii) {
      writeOutput('<tr><td>'&categories[ii].getCategoryTitle() & "</td><td>&nbsp</td><td>" &categories[ii].getDescription() & "</tr>");
    }
    writeOutput('</tbody>');
    writeOutput('</table>');
</cfscript>

<cfinclude template="/dotlog/includes/footer.cfm">

