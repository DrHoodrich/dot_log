<cfset pageTitle = "Daily Report">
<cfinclude template="/dotlog/view/header.cfm">
<cfinclude template="/dotlog/view/data_formatting.cfm">

<cfscript>
	airportCode = session.user.getAirportCode();
	airport = application.airportService.getAirportByAirportCode(airportCode);
	districtID = airport.getDistrictID();
	district = application.districtService.getDistrictByID(districtID);
	region = application.regionService.getRegionByID(district.getRegionID());
</cfscript>

<cfif structKeyExists(FORM,"viewWeeklyReport_button") is TRUE>
	<cflocation url="/dotlog/pages/generatePDF.cfm" addtoken="false">
<cfelseif structKeyExists(FORM,"viewDailyReport_button") is TRUE>
	<cflocation url="/dotlog/pages/generatePDF.cfm" addtoken="false">
</cfif>

<cfoutput>Report for #airport.getAirportName()# #printDate(now())#</cfoutput>

<cfinvoke  
    component="dotlog.model.email"  
    method="getRegionAdminEmails"  
    returnVariable="emailAddresses"> 
    <cfinvokeargument  
        name="regionID"  
        value="#region.getRegionID()#"> 
</cfinvoke> 

<cfinclude template="./stubbedGeneratePDF.cfm">

<cfset week = StructNew() />
<cfset week.today = (fix ( now () )) />
<cfset week.start = printDate(week.today - DayOfWeek(week.today) + 1) />
<cfset week.end = printDate(week.start + 6) />

<cfif structKeyExists(FORM,"submitDailyReport_button") is TRUE>
	<cfset reportType = "Daily"/>
<cfelseif structKeyExists(FORM,"submitWeeklyReport_button") is TRUE>
	<cfset reportType = "Weekly"/>	
</cfif>

<table frame="box">
	<thead><tr><th>name</th><th>email addemailAddressess</th></tr>
	<tbody>
	<cfloop query = emailAddresses>
		<tr><td><cfoutput>#first_name# </cfoutput><cfoutput>#last_name#</cfoutput></td><td><cfoutput>#email_addr#</cfoutput></td></tr>
		<cfmail from="#application.systemEmailAddr#" to=#email_addr# subject="DOTLog #reportType# Report" type="html">
			#reportType# report for hub <cfoutput>#airport.getAirportName()#</cfoutput> for #week.today#.
		<cfmailparam file="test.pdf" type="application/pdf" content="#dailyReport#"/>
	</cfmail>
	</cfloop>
    </tbody>
</table>

<cfinclude template="/dotlog/includes/footer.cfm">