<cfscript>
component
{
	this.Name =  "CheckSessionTest";
	this.ApplicationTimeout = CreateTimeSpan( 0, 0, 1, 0 );
	this.SessionManagement = true;
	this.rootDir = getDirectoryFromPath( getCurrentTemplatePath() );
	this.mappings[ "/dotlog" ] = this.rootDir;	

	public void function onApplicationStart()
	{
		var datasource = new dotlog.components.datasource(DSName = "DOTlogDB", username = "", password = "");
		Application.airportDAO = new dotlog.components.airportDAO(datasource);
		Application.categoryDAO = new dotlog.components.categoryDAO(datasource);
		Application.userDAO = new dotlog.components.userDAO(datasource);
		Application.recordDAO = new dotlog.components.recordDAO(datasource);
	}
}
</cfscript>