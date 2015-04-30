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
		Application.airportService = new dotlog.model.dataAccess.airportService(datasource);
		Application.categoryService = new dotlog.model.dataAccess.categoryService(datasource);

		Application.recordService = new dotlog.model.dataAccess.recordService(datasource);
		Application.userService = new dotlog.model.dataAccess.userService(datasource);

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