<cfset pageTitle = "Add Airport"> <!--- Variable that is used in the html included header --->
<cfinclude template="../includes/header.cfm">
<cfinclude template="../includes/banner.cfm">
    <a id="main_content"></a>
<cfinclude template="../includes/breadcrumb.cfm">
<cfinclude template="../includes/nav.cfm">
    <div id="content">
    
<!-- BEGIN YOUR CONTENT HERE -->
	<!-- TemplateBeginEditable name="main content" -->
<h2>DOTLog Add New Airport</h2>
<cfform>
	Airport Code:<cfinput type = "Text" name = "Category Code" message = "Category Code is Required" required = "yes"></cfinput> <br>
  Airport Name:<cfinput type = "Text" name = "Category Name" message = "Category Name is Required" required = "yes"></cfinput> <br>
  Hub/Region:<cfselect name = "Hub/Region" id = "Hub/Region">
    <option value="#possibleCategories[ii]#">North</option>
    <option value="#possibleCategories[ii]#">Fairbanks</option>
  </cfselect><br>
	<cfinput type="submit" name="add_airport" id="add_airport" value="Submit">
</cfform>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="../includes/footer.cfm">