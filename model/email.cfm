<cfscript>
	datasource = new dotlog.model.beans.datasource(DSName = "DOTlogDB", username = "", password = "");
	emailGW = new dotlog.model.email(datasource);
	writeDump(emailGW.getRegionAdminEmails(120));
</cfscript>