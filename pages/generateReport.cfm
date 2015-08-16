<cfset pageTitle = "Daily Report">
<cfinclude template="/dotlog/view/header.cfm">	
<cfinclude template="/dotlog/view/print_reports.cfm">

<cfscript>
	airportCode = session.user.getAirportCode();
	airport = application.airportService.getAirportByAirportCode(airportCode);
	districtID = airport.getDistrictID();
	district = application.districtService.getDistrictByID(districtID);
	region = application.regionService.getRegionByID(district.getRegionID());
</cfscript>

<cfoutput>Report for #airport.getAirportName()# #timeformat(now(), "yyyy-mm-dd")#</cfoutput>

<cfinvoke  
    component="dotlog.model.email"  
    method="getRegionAdminEmails"  
    returnVariable="res"> 
    <cfinvokeargument  
        name="regionID"  
        value="#region.getRegionID()#"> 
</cfinvoke> 

<cfinclude template="./stubbedGeneratePDF.cfm">
<table frame="box">
	<thead><tr><th>name</th><th>email address</th></tr>
	<tbody>
	<cfloop query = res>
		<tr><td><cfoutput>#first_name# </cfoutput><cfoutput>#last_name#</cfoutput></td><td><cfoutput>#email_addr#</cfoutput></td></tr>
		<cfmail from="#application.systemEmailAddr#" to=#email_addr# subject="Its late" type="html">
			Daily report for hub <cfoutput>#airport.getAirportName()#</cfoutput>
		<cfmailparam file="test.pdf" type="application/pdf" content="#dailyReport#"/>
	</cfmail>
	</cfloop>
    </tbody>
</table>

<cfinclude template="/dotlog/includes/footer.cfm">