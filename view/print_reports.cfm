<cffunction name="printAirportRecords" output="true">
	<cfargument name="airports" type="array" required="true">
	<cfloop array="#airports#" index="airport">
		<cfset records = #application.recordService.getRecordsByAirportCode(airport.getAirportCode())#>
		<cfif #arrayIsEmpty(records)# IS False>
			<cfoutput><strong>Records for #airport.getAirportName()#</strong></cfoutput>
				<cfoutput>#printRecords(records, 1)#</cfoutput>
		</cfif>
	</cfloop>
</cffunction>
	
<cffunction name="printRecords" output="true">
	<cfargument name="records" type="array" required="true">
	<cfargument name="editable" type="numeric" required="true">
		<table width="783" height="180" border=".1">
			<cfloop array="#records#" index="record">
				<tr>
					<td width="500" height="102" align="left" valign="top">
						<cfoutput>#dateformat(record.getEventTime(),  'yyyy-mm-dd') & " " & timeformat(record.getEventTime(),'hh:mm tt')#<br></cfoutput>
						<cfoutput>Reporter: #record.getUsername()# <br></cfoutput>
						<cfoutput>Airport: #record.getAirportCode()# <br></cfoutput>
						<cfoutput>Category: #application.categoryService.getCategoryTitleByID(record.getCategoryID())# <br></cfoutput>
					</td>
					
					<td width="560" align="left" valign="top">
						<cfoutput>#wrap(record.getRecordText(), 72)#</cfoutput>
					</td>
					
					<cfif #editable# IS True>
						<td width="92" align="right" valign="top">
							<cfform name="editRecord" method="post" action="edit_record_action.cfm">
								<cfinput type="hidden" name="recordID" value="#record.getRecordID()#">
								<cfinput type="submit" name="editRecord" value="Edit Event">
							</cfform>
							<cfif #record.isInWeeklyReport()# IS True>
								<strong>In Weekly</strong>
							<cfelse>
								<cfoutput>Not in Weekly</cfoutput>
							</cfif>
						</td>
					</cfif>
			</cfloop>
		</table>	
</cffunction>
		