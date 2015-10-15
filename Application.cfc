component  
{
	this.Name =  "DOTLog";
	this.ApplicationTimeout = CreateTimeSpan( 0, 0, 0, 0 );
	this.SessionManagement = true;
	this.rootDir = getDirectoryFromPath( getCurrentTemplatePath() );
	this.mappings = structNew();
	this.mappings[ "/dotlog" ] = this.rootDir;
	this.mappings[ "/includes" ] = (this.rootDir & "includes\");
	
	//Domain prefix to be removed from usernames
	this.domain = "DOTLOGDATABASEW\";

	this.systemEmailAddr = "no-reply@dotlog.ak.us.gov";
	

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

		Application.systemEmailAddr = this.systemEmailAddr;
	}

	function onRequestStart()
	{
		
	}

	function onSessionStart()
	{
		try {
			writeDump(SESSION);
			session.user = application.userService.getUserByUsername(removeChars(getAuthUser(), 1, len(this.domain)));
		} catch (any e) {
			writeDump(e);
			writeDump(SESSION);
			throw;
		}
	}

	function onError(required any e, required string EventName)
	{
		//location("/dotlog/pages/error.cfm", "false")
	}
}
