component extends = "taffy.core.api"
{
	this.Name =  "DOTLog";
	this.ApplicationTimeout = CreateTimeSpan( 0, 0, 0, 0 );
	this.SessionManagement = true;
	this.rootDir = getDirectoryFromPath( getCurrentTemplatePath() );
	this.mappings[ "/dotlog" ] = expandPath("../");
	this.mappings[ "/resources" ] = expandPath('./resources');
	this.mappings[ "/taffy" ] = expandPath("./taffy");
	this.domain = "DOTLOGDATABASEW\";

	function onApplicationStart()
	{
		var datasource = new dotlog.model.beans.datasource(DSName = "DOTlogDB", username = "", password = "");
		var serviceFactory = new dotlog.model.service.serviceFactory(datasource);

		Application.airportService = serviceFactory.get("airportService");
		Application.categoryService = serviceFactory.get("categoryService");
		Application.recordService = serviceFactory.get("recordService");
		Application.userService = serviceFactory.get("userService");
		Application.regionService = serviceFactory.get("regionService");
		Application.districtService = serviceFactory.get("districtService");

		return super.onApplicationStart();
	}

	function onRequestStart()
	{
		return super.onRequestStart();
	}

	function onSessionStart()
	{
		try {
			session.user = application.userService.getUserByUsername(removeChars(getAuthUser(), 1, len(this.domain)));
		} catch(any expt) {
			writeDump('UH OH');
		}

	}
}