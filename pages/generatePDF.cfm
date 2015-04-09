<cfdocument format="PDF">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>Hello World</title>
</head>
<body>
    <cfoutput><strong>DOTLog Northern Region Special Report #dateformat(now(), "yyyy-mm-dd")# <hr></strong></cfoutput>
    <cfscript>
	   if (structKeyExists(FORM,"reports")) {
	   	writeOutput(FORM.reports);
	   } 
    </cfscript>
</body>
</html>
</cfdocument>