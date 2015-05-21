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
		var serviceFactory = new dotlog.model.service.serviceFactory(datasource);

		Application.categoryService = serviceFactory.get("categoryService");
		Application.recordService = serviceFactory.get("recordService");
		Application.userService = serviceFactory.get("userService");
		Application.airportService = serviceFactory.get("airportService");
		Application.reportService = serviceFactory.get("reportService");
		Application.regionService = serviceFactory.get("regionService");
		Application.districtService = serviceFactory.get("districtService");
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

