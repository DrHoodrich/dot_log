<cfset pageTitle = "Update Event"> <!--- Variable that is used in the html included header --->
<cfinclude template="../includes/header.cfm">
<cfinclude template="../includes/banner.cfm">
  <a id="main_content"></a>
<cfinclude template="../includes/breadcrumb.cfm">
<cfinclude template="../includes/nav.cfm">
    <div id="content">
    
<!-- BEGIN YOUR CONTENT HERE -->
  <!-- TemplateBeginEditable name="main content" -->
<cfoutput><h2>#pageTitle#</h2></cfoutput>

<cfscript>
  record = application.recordService.getRecordByID(FORM.recordID);
  
  if ( !structKeyExists(FORM,"inWeeklyReport") ) {
    FORM.inWeeklyReport = 0;
  }

  FORM.username = record.getUsername();
  FORM.recordTime = record.getRecordTime();
  FORM.FAACode = record.getAirportFAACode();
  
  updatedRecord = new dotlog.components.record(argumentCollection=FORM);
  
  if ( application.recordService.saveRecord(updatedRecord) ) {
    writeoutput("<strong>Record Updated</strong>");
  } else {
    writeoutput("<strong>Record Updating Failed</strong>");
  }
</cfscript>

  <!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="../includes/footer.cfm">