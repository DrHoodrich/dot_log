<cfset pageTitle = "Update Event"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/view/header.cfm">
    
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
  FORM.eventTime = FORM.eventDate & " " & FORM.eventTime;
  
  updatedRecord = new dotlog.model.beans.record(argumentCollection=FORM);
  
  if ( application.recordService.save(updatedRecord) ) {
    writeoutput("<strong>Record Updated</strong>");
  } else {
    writeoutput("<strong>Record Updating Failed</strong>");
  }
</cfscript>

  <!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">