<cfdocument format="PDF">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>A PDF!</title>
</head>
<body>
    <cfoutput><strong>DOTLog Northern Region #dateformat(now(), "yyyy-mm-dd")# Report  <hr></strong></cfoutput>
    <cfscript>
	    
	 if ( structKeyExists(FORM, "submitReportEmail_button")) {
    	airports = application.airportService.getChildAirports(session.user.getAirportFAACode());
    	categories = application.categoryService.getAllCategories();
  
		  writeOutput('<table width="783" height="180" border="1">');
		    for (ii = 1; ii <= arrayLen(airports); ++ii) {
		      records = application.recordService.getRecordsByAirportFAACode(airports[ii].getFAACode());

		      for (jj = 1; jj <= arrayLen(records); ++jj) {
		        checked = '';
		        if (records[jj].isInWeeklyReport()) {
		          checked = 'checked="True"';
		        } else {
		          continue;
		        }
		        writeOutput('<tr> <td width="117" height="102" align="left" valign="top"> #records[jj].getEventTime()# <br>');
		        writeOutput(' Reporter: #records[jj].getUsername()# <br>Airport: #records[jj].getAirportFAACode()# <br> Category: #records[jj].getCategory()# <br>');
		        writeOutput('<td width="560" align="left" valign="top">#records[jj].getRecordText()#</td>');
		      }
		    }
		  writeOutput('</table>');
	   } 

    </cfscript>
</body>
</html>
</cfdocument>