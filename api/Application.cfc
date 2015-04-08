component extends = "taffy.core.api"
{
	this.Name =  "DOTLog";
	this.ApplicationTimeout = CreateTimeSpan( 0, 0, 0, 0 );
	this.SessionManagement = true;
	this.rootDir = getDirectoryFromPath( getCurrentTemplatePath() );
	this.mappings[ "/dotlog" ] = expandPath("../");
	this.mappings[ "/resources" ] = expandPath('./resources');
	this.mappings[ "/taffy" ] = expandPath("./taffy");

	function onApplicationStart()
	{
		var datasource = new dotlog.components.datasource(DSName = "DOTlogDB", username = "", password = "");
		Application.airportDAO = new dotlog.components.airportDAO(datasource);
		Application.categoryDAO = new dotlog.components.categoryDAO(datasource);

		Application.recordService = new dotlog.components.recordService(datasource);
		Application.userService = new dotlog.components.userService(datasource);

		return super.onApplicationStart();
	}

	function onRequestStart()
	{
		return super.onRequestStart();
	}

	
}