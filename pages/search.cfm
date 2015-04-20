<cfset pageTitle = "Search"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/includes/header.cfm">
<cfinclude template="/dotlog/includes/banner.cfm">
	<a id="main_content"></a>
<cfinclude template="/dotlog/includes/breadcrumb.cfm">
<cfinclude template="/dotlog/includes/nav.cfm">
	<div id="content">
	
<!-- BEGIN YOUR CONTENT HERE -->
  <!-- TemplateBeginEditable name="main content" -->
<cfoutput><h2>#pageTitle#</h2></cfoutput>
<cfform name="search" action="search_action.cfm" method="post">
	Keyword:<cfinput type = "text" name = "keyword" message = " " required = "no"></cfinput> <br>
	User:<cfinput type = "text" name = "username" message = " " required = "no"></cfinput> <br>
	<!--- first name:<cfinput type = "text" name = "firstName" message = " " required = "no"></cfinput> <br>
	last name:<cfinput type = "text" name = "lastName" message = " " required = "no"></cfinput> <br> --->
	FAA Code:<cfinput type = "text" name = "airportCode" message = "" required = "no"></cfinput> <br>
	Category:<cfinput type = "text" name = "categoryTitle" message = "categoryTitle" required = "no"></cfinput> <br>
	From: <cfinput type = "datefield" name = "startDate" message = "" value="04/10/2015">
	To: <cfinput type = "datefield" name = "endDate" message = "" value="04/10/2015"><br>
	
	
	<cfinput type="submit" name="submitSearch_button" id="searchRecords" value="search"> <br>
</cfform>
  <!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">