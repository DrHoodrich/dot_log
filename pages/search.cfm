<cfset pageTitle = "Search"> <!--- Variable that is used in the html included header --->
<cfinclude template="../includes/header.cfm">
<cfinclude template="../includes/banner.cfm">
  <a id="main_content"></a>
<cfinclude template="../includes/breadcrumb.cfm">
<cfinclude template="../includes/nav.cfm">
    <div id="content">
    
<!-- BEGIN YOUR CONTENT HERE -->
  <!-- TemplateBeginEditable name="main content" -->
<cfoutput><h2>#pageTitle#</h2></cfoutput>
<cfform name="search" action="search_action.cfm" method="post">
  Userame:<cfinput type = "text" name = "username" message = "username" required = "no"></cfinput> <br>
  FAA Code:<cfinput type = "text" name = "faaCode" message = "faaCode" required = "no"></cfinput> <br>
  <cfinput type="submit" name="submitSearch_button" id="searchRecords" value="search"> 
</cfform>
  <!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="../includes/footer.cfm">