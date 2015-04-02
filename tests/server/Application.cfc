<cfscript>
component Application 
{
	this.name = hash( getCurrentTemplatePath() );
	this.applicationTimeout = createTimeSpan( 0, 0, 5, 0 );
	this.sessionManagement = false;
	this.directory = getDirectoryFromPath( getCurrentTemplatePath() );
	this.mxunitDirectory = (this.directory & "../mxunit/");
	this.appDirectory = (this.directory & "../../");
	this.mappings[ "/mxunit" ] = this.mxunitDirectory;
	this.mappings[ "/model" ] = (this.appDirectory & "model/");
	this.mappings[ "/spec" ] = (this.directory & "spec/");
}
</cfscript>