<cfset pageTitle = "DOTLog Login"> <!--- Variable that is used in the html included header --->
<cfinclude template="../includes/header.cfm">
  <a id="main_content"></a>
<cfinclude template="../includes/breadcrumb.cfm">
<cfinclude template="../includes/nav.cfm">
    <div id="content">

<!-- BEGIN YOUR CONTENT HERE -->
	<!-- TemplateBeginEditable name="main content" -->
<cfoutput><h2>#pageTitle#</h2></cfoutput>
<cfform name="login" method="post" action="login_action.cfm">
  <label for="userName">Username:</label>
	   <cfinput type = "text" name = "userName" message = "Username is Required" required = "yes"></cfinput> <br>
	<cfinput type="submit" name="userNameSubmit" id="userNameSubmit" value="Submit">
</cfform>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="../includes/footer.cfm">