<cfset pageTitle = "Daily Report"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/view/header.cfm">

	
	    	
	
<cfinclude template="/dotlog/view/print_reports.cfm">
<cfscript>
	pdfData = "Hello World!";
</cfscript>

<cfdump var = #pdfData#>

<cfinvoke  
    component="dotlog.model.email"  
    method="getRegionAdminEmails"  
    returnVariable="res"> 
    <cfinvokeargument  
        name="regionID"  
        value="649"> 
</cfinvoke> 
<cfdump var=#res#>
<cfinclude template="./stubbedGeneratePDF.cfm">
<table frame="box">
	<thead><tr><th>name</th><th>email address</th></tr>
	<tbody>

	<cfloop query = res>
		<tr><td><cfoutput>#first_name# </cfoutput><cfoutput>#last_name#</cfoutput></td><td><cfoutput>#email_addr#</cfoutput></td></tr>
		<cfmail from="#application.systemEmailAddr#" to=#email_addr# subject="Its late" type="html">
			Looping!
		<cfmailparam file="test.pdf" type="application/pdf" content="#dailyReport#"/>
	</cfmail>
	</cfloop>
    </tbody>
</table>

<cfinclude template="/dotlog/includes/footer.cfm">