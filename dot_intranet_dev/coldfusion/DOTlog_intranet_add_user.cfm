<cfset pageTitle = "DOTLog Record Creation"> <!--- Variable that is used in the html included header --->
<cfinclude template="header.cfm">

<body>
	<a id="top"></a>
  <a href="#main_content" class="hidden">Skip to content</a>
	  <div id="container">

<!-- DOTPF INTRANET TOP MENU -->
	<!--#include virtual="/ssis/dotpf_intranet_topnav.html" -->
<!------>

    <div id="header"><!-- BEGIN HEADER -->
    
<!-- HEADER BANNER -->
	<!-- TemplateBeginEditable name="main header" -->
    	<a id="title" href="http://web.dot.state.ak.us">
      		<span>
            	<img src="/images/hdrs/header_plain_dotpf.gif" alt="DOT&amp;PF Intranet Header" width="1000" height="90">
            </span>
            	Alaska DOT &amp; PF Employee Intranet / Aviation
		</a>
	<!-- TemplateEndEditable -->
<!------>

<!-- SOA SEARCH BOX - SERVER SIDE INCLUDE -->
<!------>

    </div><!-- END HEADER -->

    <a id="main_content"></a>

<!-- BEGIN BREADCRUMBS -->
	<div id="breadcrumbs">
   	  <a href="http://web.dot.state.ak.us">DOT&amp;PF Employee Intranet</a>> <!-- TemplateBeginEditable name="Breadcrumbs" -->
      <cfinclude template="breadcrumb.cfm">
	  <!-- TemplateEndEditable -->
	</div> 
<!-- END BREADCRUMBS -->
<cfinclude template="nav.cfm">
    <div id="content">
    
<!-- BEGIN YOUR CONTENT HERE -->
	<!-- TemplateBeginEditable name="main content" -->
<h2>DOTLog Add User</h2>
<cfform>
	User Name:<cfinput type = "Text" name = "User Name" message = "User Name" required = "yes"></cfinput> <br>
	User Initials:<cfinput type = "Text" name = "User Initials" message = "User Initials" required = "yes"></cfinput> <br>
	Hub/Region:<cfselect name = "User Hub" id = "User Hub">
		<option value="#possibleCategories[ii]#">Fairbanks</option>
		<option value="#possibleCategories[ii]#">Fairbanks</option>
		<option value="#possibleCategories[ii]#">Fairbanks</option>
	</cfselect><br>
	Airport:<cfselect name = "User Airport" id = "User Airport">
		<option value="#possibleCategories[ii]#">Fairbanks</option>
		<option value="#possibleCategories[ii]#">Fairbanks</option>
		<option value="#possibleCategories[ii]#">Fairbanks</option>
	</cfselect><br>
	Account Type:<cfselect name = "User Type" id = "User Type">
		<option value="#possibleCategories[ii]#">Bearded Admin</option>
		<option value="#possibleCategories[ii]#">Talvinator</option>
	</cfselect><br>
	<cfinput type="submit" name="add_user" id="add_user" value="Submit">
</cfform>


	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->

      <div class="clear"></div>
    </div>
    
<!-- SOA AND DOT FOOTERS - SERVER SIDE INCLUDES -->
<cfinclude template="footer.cfm">