<cfset pageTitle = "Add Category"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/includes/header.cfm">
<cfinclude template="/dotlog/includes/banner.cfm">
    <a id="main_content"></a>
<cfinclude template="/dotlog/includes/breadcrumb.cfm">
<cfinclude template="/dotlog/includes/nav.cfm">
    <div id="content">
    
<cfoutput><h2>#pageTitle#</h2></cfoutput>
<cfform name="search" action="add_category_action.cfm" method="post">
  Category Title:<cfinput type="text" name = "categoryTitle" message="username" required="yes"></cfinput> <br>
  Category Description:<cfinput type="text" name="description" message="airportCode" required="no"></cfinput> <br>
  In Weekly Report:<cfinput type="checkbox" name="inWeeklyReport" required="no"></cfinput> <br>
  <cfinput type="hidden" name="enabled" value="1"/>
  <cfinput type="submit" name="newCategory_button" id="addCategory" value="create"></cfinput>
</cfform>

<cfinclude template="/dotlog/includes/footer.cfm">