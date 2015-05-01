<cfdocument format="PDF" name="pdfData">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>A PDF!</title>
</head>
<body>
    
    <cfoutput><strong>DOTLog #dateformat(now(), "yyyy-mm-dd")# Report<hr></strong></cfoutput>
    
    <cfinclude template="/dotlog/view/print_reports.cfm">
    <cfscript>    
		if ( structKeyExists(FORM, "submitReportEmail_button")) {
			airports = application.airportService.getChildAirports(session.user.getAirportCode());
			categories = application.categoryService.getAllCategories();
			printAirportRecords(airports);
		} 
	</cfscript>
</body>
</html>
</cfdocument>