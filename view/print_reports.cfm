<cfscript>

	function printRecords(required array records)
	{
		writeOutput('<table width="783" height="180" border="1">');
		for (ii = 1; ii <= arrayLen(records); ++ii) {
			writeOutput('<tr> <td width="117" height="102" align="left" valign="top"> #records[ii].getEventTime()# <br>');
			writeOutput(' Reporter: #records[ii].getUsername()# <br>Airport: #records[ii].getAirportCode()# <br>');
			writeOutput('Category: #records[ii].getCategory()# <br>');
			writeOutput('<td width="560" align="left" valign="top">#records[ii].getRecordText()#</td>');
			writeOutput('<td width="92" align="right" valign="top">');
			if ( records[ii].isInWeeklyReport() ) {
				writeOutput('In Reports');
			}
			writeOutput('<form name="editRecord" method="post" action="edit_record_action.cfm"> <input type="hidden" name="recordID" value="#records[ii].getRecordID()#"> <input type="submit" name="editRecord" value="Edit Event"> </form></td>');
		}
		writeOutput('</table>');
	}

	function printAirportRecords(required array airports)
	{
		for (ii = 1; ii <= arrayLen(airports); ++ii) {
			records = application.recordService.getRecordsByAirportCode(airports[ii].getAirportCode());
			printRecords(records);
		}
	}
</cfscript>