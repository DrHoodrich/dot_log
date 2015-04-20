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
  if ( structKeyExists(FORM,"saveUser_button") ) {
    user =  new dotlog.model.user(argumentCollection=FORM);
    if ( application.userService.saveUser(user) ) {
      writeOutput("<h3>Saved User: " & user.getUsername()& "</h3>");
    } else {
      writeOutput("<h3>Failed to save user</h3>");
    }
  }
</cfscript>

  <!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">