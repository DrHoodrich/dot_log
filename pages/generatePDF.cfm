<cfinclude template="/dotlog/pages/data_formatting.cfm">
<cfsavecontent variable="PDFhtml">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Untitled Document</title>
</head>
<body>
    <cfoutput><strong>DOTLog #printDate(now())# Report<hr></strong></cfoutput>
    <cfinclude template="/dotlog/view/print_reports.cfm">
</body>
</html>
</cfsavecontent>

<!--- USES THE VARIABLE DEFINED ABOVE TO CREATE THE PDF USING CF TAGS --->
<cfheader name="Content-Disposition" value="inline; filename=Test.pdf">
<cfdocument format="pdf">
  <cfoutput>
    #variables.PDFhtml#
  </cfoutput>
</cfdocument>

<!---<cfdocument format="PDF" name="pdfData">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>A PDF!</title>
</head>
<body>

</body>
</html>
</cfdocument>--->