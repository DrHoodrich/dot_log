<cfdocument format="PDF" name="pdfData">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>A PDF!</title>
</head>
<body>
    
    <cfoutput><strong>DOTLog #dateformat(now(), "yyyy-mm-dd")# Report<hr></strong></cfoutput>
    <cfinclude template="/dotlog/view/print_reports.cfm">
</body>
</html>
</cfdocument>