<cfset pageTitle = "DOTLog Record Creation">
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
	categories = application.categoryService.getAllCategories();
	if ( structKeyExists(FORM, "recordID") ) {
		record = application.recordService.getRecordByID(FORM.recordID);
	}
</cfscript>

<cfform name="updateCategory" action="saveRecord.cfm" method="post">
	<cfinput type="hidden" name="recordID" value="#record.getRecordID()#"></cfinput>
	<cfoutput>Reporter: <strong>"#record.getUsername()#"</strong></cfoutput><br>
  	<cfoutput>Airport: <strong>"#record.getAirportFAACode()#"</strong></cfoutput><br>

    <cfoutput>Catecory: </cfoutput>
  	<cfselect name="categoryTitle"> 
  		<cfscript>
			writeOutput('<option value="#record.getCategory()#">"#record.getCategory()#"</option>');
			for (ii = 1; ii <= arrayLen(categories); ++ii) {
				writeOutput('<option value=#categories[ii].getCategoryTitle()#>#categories[ii].getCategoryTitle()#</option>');
			}  
  		</cfscript>
 	</cfselect><br>

  	<cfoutput>Event Time: </cfoutput>
  		<cfinput type="text" name="eventTime" value="#record.getEventTime()#"></cfinput><br>
  	<cfoutput>Event Description: </cfoutput>
  		<cftextarea name="recordText" cols="40" rows="5" value="#record.getRecordText()#"></cftextarea><br>
  	<cfoutput>Include In Weekly Report: </cfoutput>
   		<cfinput type="checkbox" name="inWeeklyReport" required="no" value="1" checked="#record.isInWeeklyReport()#"></cfinput> <br>
    <cfinput type="submit" name="updateRecord_button" value="Update Record"></cfinput>
</cfform>
	<!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">