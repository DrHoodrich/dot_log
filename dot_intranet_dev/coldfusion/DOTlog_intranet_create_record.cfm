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

<!--- Hard coded until LDAP info. ---> 
	<cfscript>
		user = new user("joe"); //should be passed in by the login page
		userID = user.getID();
		airports = user.getAirportID();

		cat = new category();
		possibleCategories = cat.getCategoryNames();
	</cfscript>
    
<h2>DOTLog Log Record</h2>

<form name="form5" method="post" action="record_action.cfm">

<!--- Need to change how user info is passed into the action page --->
<cfscript>
	writeOutput('<input type = "hidden" name="USER_ID" value="#userID#">');
</cfscript>

       
<label for="AIRPORT_CODE">Airport:</label>
	<select name="AIRPORT_CODE">
			<cfscript>
				writeOutput('<option value="none"></option>');
				for (ii = 1; ii <= arrayLen(airports); ++ii) {
					writeOutput('<option value=#airports[ii]#>#airports[ii]#</option>');
				}
			</cfscript>
	</select>

	 <br>
<label for="EVENT_CATEGORY">Category:</label>
	<select name="EVENT_CATEGORY" id="EVENT_CATEGORY">
		<cfscript>
			writeOutput('<option value="none"></option>');
			for (ii = 1; ii <= arrayLen(possibleCategories); ++ii) {
				writeOutput('<option value=#possibleCategories[ii]#>#possibleCategories[ii]#</option>');
			}
		</cfscript>
 	</select>
    	
		<br>
<textarea name="EVENT_DESCRIPTION" cols="80" rows="10" id="EVENT_DESCRIPTION">Report Details</textarea>

		<br>
<label for="INCLUDE_WEEKLY_REPORT">Include in weekly report:</label>
	<input type="checkbox" name="INCLUDE_WEEKLY_REPORT" value="yes" id="INCLUDE_WEEKLY_REPORT">
		
		<br>
<input type="submit" name="add_event" id="add_event" value="Submit">

</form>
     
		<br>

<!--- Gets the latest records and displays under form entry --->		
<cfscript>
	records = new Record(user.getAirportID()[1]); 
	descriptions = records.getDescriptions();
	airport = records.getAirport();
	user = records.getReporter();
	category = records.getCategory();
	date = records.getDate();

  writeOutput('<table width="783" height="180" border="1">');
  for (ii = 1; ii<=arrayLen(descriptions); ++ii) {
		writeOutput('<tr> <td width="117" height="102" align="left" valign="top"> #date[ii]# <br>');
		writeOutput(' Reporter: #user[ii]# <br>Airport: #airport[ii]# <br> Category: #category[ii]# <br>');
		writeOutput('<td width="560" align="left" valign="top">#descriptions[ii]#</td>');
		writeOutput('<td width="92" align="right" valign="top"><form name="form1" method="post" action="">');
		writeOutput('<input type="checkbox" name="event_1_important" id="event_1_important">');
		writeOutput('<label for="event_#ii#_important">Important</label>');
		writeOutput('<label for="entry_1_important"></label></form></td>');
  }
  writeOutput('</table>');
</cfscript>


	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->

      <div class="clear"></div>
    </div>
    
<!-- SOA AND DOT FOOTERS - SERVER SIDE INCLUDES -->
<cfinclude template="footer.cfm">