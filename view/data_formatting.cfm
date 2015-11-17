<cffunction name="printDate" output="false">
	<cfargument name="date" required="true">
	<cfreturn #dateFormat(date, 'dd-mm-yyyy')#>
</cffunction>

<cffunction name="printTime" output="false">
	<cfargument name="time" required="true">
	<cfreturn #timeFormat(time, 'hh:mm tt')#>
</cffunction>