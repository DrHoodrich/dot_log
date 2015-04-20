component  
{
	this.Name =  "DOTLog";
	this.ApplicationTimeout = CreateTimeSpan( 0, 0, 0, 0 );
	this.SessionManagement = true;
	this.rootDir = getDirectoryFromPath( getCurrentTemplatePath() );
	this.mappings = structNew();
	this.mappings[ "/dotlog" ] = this.rootDir;
	this.mappings[ "/includes" ] = (this.rootDir & "includes\");

	function onApplicationStart()
	{
		var datasource = new dotlog.model.beans.datasource(DSName = "DOTlogDB", username = "", password = "");
		
		Application.categoryService = new dotlog.model.dataAccess.categoryService(datasource);
		Application.recordService = new dotlog.model.dataAccess.recordService(datasource);
		Application.userService = new dotlog.model.dataAccess.userService(datasource);
		Application.airportService = new dotlog.model.dataAccess.airportService(datasource);
	}

	function onRequestStart()
	{
		
	}

	function onSessionStart()
	{
		try {
			session.user = application.userService.getUserByUsername(getAuthUser()); // <-- isn't working :(
		} catch (any expt) {
			//writeDump(session.user);
			writeDump(expt);
			onApplicationStart();
		}
	}
}
