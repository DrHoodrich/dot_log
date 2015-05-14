component  
{
	this.Name =  "DOTLog";
	this.ApplicationTimeout = CreateTimeSpan( 0, 0, 0, 0 );
	this.SessionManagement = true;
	this.rootDir = getDirectoryFromPath( getCurrentTemplatePath() );
	this.mappings = structNew();
	this.mappings[ "/dotlog" ] = this.rootDir;
	this.mappings[ "/includes" ] = (this.rootDir & "includes\");
	this.domain = "DOTLOGDATABASEW\";

	function onApplicationStart()
	{
		var datasource = new dotlog.model.beans.datasource(DSName = "DOTlogDB", username = "", password = "");
		
		Application.categoryService = new dotlog.model.service.categoryService(datasource);
		Application.recordService = new dotlog.model.service.recordService(datasource);
		Application.userService = new dotlog.model.service.userService(datasource);
		Application.airportService = new dotlog.model.service.airportService(datasource);
		Application.reportService = new dotlog.model.service.reportService(datasource);
	}

	function onRequestStart()
	{
		
	}

	function onSessionStart()
	{
		try {
			session.user = application.userService.getUserByUsername(removeChars(getAuthUser(), 1, len(this.domain)));
		} catch (any e) {
			writeDump(SESSION);
			throw;
		}
	}

	function onError(required any e, required string EventName)
	{
		if (arguments.EventName == "onSessionStart") {
			if (e.Type == "InvalidData") {
				include "/dotlog/templates/error.cfm";
			}
		}
	}
}

