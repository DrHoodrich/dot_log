<cfset pageTitle = "Daily Report"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/view/header.cfm">

	<table frame="box">
	    <thead><tr><th>name</th><th>email address</th><th>Region/Hub</th></tr>
	    <tbody>
	    	<tr><td>TODO - Put in email addresses.</td></tr>
	    </tbody>
    </table>
	
<cfinclude template="/dotlog/view/print_reports.cfm">
<cfscript>
	pdfData = "Hello World!";
</cfscript>

<cfdump var = #pdfData#>
<cfinclude template="./stubbedGeneratePDF.cfm">
<cfmail from="#application.systemEmailAddr#" to="bjfrost2@alaska.edu" subject="Its late" type="html">
	hERE IS A body for you.
	<cfmailparam file="test.pdf" type="application/pdf" content="#dailyReport#"/>
</cfmail>

<cfinclude template="/dotlog/includes/footer.cfm">