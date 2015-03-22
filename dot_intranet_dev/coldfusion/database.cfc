<cfscript>
component Database {
        public void function saveRecord(required Record submittedRecord) {
		iter = submittedRecord.getRecord();
	}
}
</cfscript>