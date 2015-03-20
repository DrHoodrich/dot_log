<cfset pageTitle = "DOTLog Record Entry"> <!--- Variable that is used in the html included header --->
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
            	Alaska DOT &amp; PF Employee Intranet / Division or Section Name
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
  

  <!--- TODO 
        * Get the hub ID from user to generate the list of airports
        * Get commonly used Categories?
  --->

  <cfscript>
    user = new user("joe"); //should be passed in by the login page

    //query for the airports
    airports = user.getAirportID();

    cat = new category();
    possibleCategories = cat.getCategoryNames();
  </cfscript>
    <h2>Search Events</h2>

    <form name="LOG_QUERY" method="post" action=""> <!---Action is the page to send it to --->
      <p>
         <input type="text" name="db_search_bar" id="db_search_bar" value="Search">
      </p>
       <p>
         <label for="date_range_start">from:</label>
         <input type="text" name="date_range_begin" id="date_range_start" value="mm/dd/yyyy">
         <label for="date_range_end">to:</label>
         <input type="text" name="date_range_end" id="date_range_end" value="mm/dd/yyyy">
       </p>
       <p>
         <label for="airport_id">airport:</label>
         <select name="airport_id">
            <cfscript>
              writeOutput('<option value="none">none</option>');
              for (ii = 1; ii <= arrayLen(airports); ++ii) {
                writeOutput('<option value=airports[ii]>#airports[ii]#</option>');
              }
            </cfscript>
         </select>
       </p>
       <p>
         <label for="event_category">Category:</label>
         <select name="event_category" id="event_category">
         
         <cfscript>
              writeOutput('<option value="none">none</option>');
              for (ii = 1; ii <= arrayLen(possibleCategories); ++ii) {
                writeOutput('<option value=airports[ii]>#possibleCategories[ii]#</option>');
              }
            </cfscript>
         </select>
      </p>
</form>

	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->

      <div class="clear"></div>
    </div>
    
<!-- SOA AND DOT FOOTERS - SERVER SIDE INCLUDES -->    
	<!--#include virtual="/ssis/dot_intranet_footer.html" -->
</div>   
</body>
</html>
