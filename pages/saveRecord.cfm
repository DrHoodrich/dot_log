<cfset pageTitle = "Update Event">
<cfinclude template="/dotlog/view/header.cfm">
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
  
  if ( application.recordService.saveRecord(updatedRecord) ) {
    writeoutput("<strong>Record Updated</strong>");
  } else {
    writeoutput("<strong>Record Updating Failed</strong>");
  }
</cfscript>
<cfinclude template="/dotlog/includes/footer.cfm">