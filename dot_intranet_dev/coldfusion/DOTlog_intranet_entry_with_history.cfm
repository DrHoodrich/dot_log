<cfinclude template="header.cfm">


	<link rel="shortcut icon" href="http://www.dot.alaska.gov/favicon.ico"> 
    <link rel="icon" type="image/ico" href="http://www.dot.alaska.gov/favicon.ico">

<link href="/style_sheets/dot_main-intranet_style.css" rel="stylesheet" type="text/css" media="projection, screen">
<link href="/style_sheets/menu-intra.css" rel="stylesheet" type="text/css" />
<link href="/style_sheets/print_intra.css" rel="stylesheet" type="text/css" media="print">
<!--[if IE 6]>
	<link href="/style_sheets/ie6.css" rel="stylesheet" type="text/css" media="projection, screen">
<![endif]-->
<!-- This is the son of suckerfish dropdown javascript code for IE-->
<script type="text/javascript"><!--//--><![CDATA[//><!--
sfHover = function() {
	var sfEls = document.getElementById("menu_list").getElementsByTagName("LI");
	for (var i=0; i<sfEls.length; i++) {
		sfEls[i].onmouseover=function() {
			this.className+=" sfhover";
		}
		sfEls[i].onmouseout=function() {
			this.className=this.className.replace(new RegExp(" sfhover\\b"), "");
		}
	}
}
if (window.attachEvent) window.attachEvent("onload", sfHover);
//--><!]]></script>

<!-- TemplateBeginEditable name="optional_css_area" -->
<style>
    ul {
    	list-style-type: none;
        margin: 0;
        padding: 0;
    }
  	li {
  		display: inline;
  		margin: 0;
  		padding: 0;
  	}
</style>
<!-- TemplateEndEditable -->

</head>
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
   	  <a href="http://web.dot.state.ak.us">DOT&amp;PF Employee Intranet</a>> <!-- TemplateBeginEditable name="Breadcrumbs" --><a href="">Breadcrumbs</a>
	  <!-- TemplateEndEditable -->
	</div> 
<!-- END BREADCRUMBS -->
      <!-- BEGIN MENU -->   
 	<div id="menu"> 
  	  <ul id="nav" class="dropdown dropdown-horizontal">
	<!-- TemplateBeginEditable name="Dropdown Menu" -->
	    <li><a href="DOTlog_intranet_login.html">Logout</a></li>
	    <li><a href="./DOTlog_intranet_entry_only.html">Incident Report</a>
        <li><a href="./DOTlog_intranet_entry_with_history.html">Daily Report</a></li>
		<li><a href="./DOTlog_intranet_search.html">Search</a></li>
	<!-- TemplateEndEditable -->
	  </ul>
	</div>
<!-- END MENU -->
    <div id="content">
    
<!-- BEGIN YOUR CONTENT HERE -->
	<!-- TemplateBeginEditable name="main content" -->
    <h2>Search Events</h2>
<form name="LOG_QUERY" method="post" action="">
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
         	<option value="none">none</option>
       	   <option value="cicle city">cicle City</option>
            <option value="Fort Yukon">Fort Yukon</option>
            <option value="Kaltag">Kaltag</option>
         </select>
       </p>
       <p>
         <label for="event_category">Category:</label>
         <select name="event_category" id="event_category">
         <option value="none">none</option>
         	<option value="Hazard">Hazard</option>
            <option value="Lighting">Lighting</option>
            <option value="Medevac">Medevac</option>
         </select>
      </p>
</form>
     <table width="792" height="282" border="1">
       <tr>
         <td width="689" align="left" valign="top"><table width="783" height="180" border="1">
           <tr>
             <td width="117" height="102" align="left" valign="top"><p>02/12/2015</p>
              <p>Reporter: JW</p>
              <p>Airport: Fort Yukon</p>
              <p>Category: Fuel</p></td>
             <td width="560" align="left" valign="top">Stub for Fuel report.</td>
             <td width="92" align="right" valign="top"><form name="form1" method="post" action="">
               <p>
                 <input type="submit" name="edit_entry_1" id="edit_entry_1" value="Edit">
               </p>
               <p>
                 <input type="checkbox" name="event_1_important" id="event_1_important">
                 <label for="event_1_important">Important</label>
                 <label for="entry_1_important"></label>
               </p>
             </form></td>
           </tr>
           <tr>
             <td><p>02/13/2015</p>
              <p>Reporter: SB</p>
              <p>Airport: Clear</p>
              <p>Category: Medevac</p></td>
             <td align="left" valign="top">Stub for Medevac report.</td>
             <td align="right" valign="top"><form name="form2" method="post" action="">
               <p>
                 <input type="submit" name="edit_report_2" id="edit_report_2" value="Edit">
               </p>
               <p>
                 <input name="event_report_2_important" type="checkbox" id="event_report_2_important" checked>
                 <label for="event_report_2_important">Important</label>
               </p>
             </form></td>
           </tr>
           <tr>
             <td><p>02/16/2015</p>
              <p>Reporter: HR</p>
              <p>Airport: VOR Lake</p>
              <p>Category: Lighting</p></td>
             <td align="left" valign="top">Stub for Lighting report.</td>
             <td align="right" valign="top"><form name="form3" method="post" action="">
               <p>
                 <input type="submit" name="edit_report_3" id="edit_report_3" value="Edit">
               </p>
               <p>
                 <input type="checkbox" name="event_3_important" id="event_3_important">
                 <label for="event_3_important">Important</label>
               </p>
             </form></td>
           </tr>
         </table></td>
       </tr>
     </table>
     <h2>Add New Event</h2>
     <form name="form5" method="post" action="">
       <p>
<label for="AIRPORT_ID">Airport:</label>
         <select name="AIRPORT_ID">
         	<option value="none">none</option>
         	<option value="Cicle City">Cicle City</option>
            <option value="Fort Yukon">Fort Yukon</option>
            <option value="Kaltag">Kaltag</option>
         </select>
       </p>
       <p>
         <label for="EVENT_CATEGORY">Category:</label>
         <select name="EVENT_CATEGORY" id="EVENT_CATEGORY">
         <option value="none">none</option>
         	<option value="Hazard">Hazard</option>
            <option value="Lighting">Lighting</option>
            <option value="Medevac">Medevac</option>
         </select>
         
         <label for="log report"></label>
       </p>
       <p>
         <label>
           <textarea name="log report" cols="80" rows="10" id="log report">Report Details</textarea>
           <br>
           <input type="checkbox" name="NEW_EVENT_OPTIONS" value="yes" id="NEW_EVENT_OPTIONS_0">
         </label>

         <label>Important</label>
         <br>
         
       </p>
     </form>
     <a href="./DOTlog_intranet_entry_only.html"><input type="submit" name="new_event_submit" id="new_event_submit" value="Submit"></a>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->

      <div class="clear"></div>
    </div>
    
<!-- SOA AND DOT FOOTERS - SERVER SIDE INCLUDES -->    
	<!--#include virtual="/ssis/dot_intranet_footer.html" -->
</div>   
</body>
</html>
