<cfscript>
component
{
	this.Name =  "CheckSessionTest";
	this.ApplicationTimeout = CreateTimeSpan( 0, 0, 1, 0 );
	this.SessionManagement = true;
	this.rootDir = getDirectoryFromPath( getCurrentTemplatePath() );
	//this.mxunitDir = (this.rootDir & "../mxunit/"); 
//	this.mappings[ "/mxunit" ] = this.rootDir & "mxunit/";
//	this.mappings[ "/spec" ] = this.rootDir & "component/";
	this.mappings[ "/dotlog" ] = this.rootDir;


	//myfile = FileOpen("c:\temp\test1.txt", "append");
//	fileWrite("c:\cflog.txt",this.rootDir & "  " &  this.mappings["/mxunit"]);
}
</cfscript>