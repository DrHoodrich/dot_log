<cfscript>
	databaseConnector = new database();
	
	databaseConnector.saveRecord(Form.USER_ID, Form.EVENT_DESCRIPTION);
</cfscript>