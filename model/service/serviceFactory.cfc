component ServiceFactory
{
	variables.instance = {
		datasource = ''
	};

	public ServiceFactory function init(required dotlog.model.beans.datasource datasource)
	{
		variables.instance.datasource = arguments.datasource;
		return this;
	}

	public Service function get(required string serviceType)
	{
		DAO = '';
		GW = '';
		service = '';
		switch(serviceType) {
			case "airportService":
				DAO = new dotlog.model.dataAccess.airportDAO(variables.instance.datasource);
				GW = new dotlog.model.dataAccess.airportGateway(variables.instance.datasource);
				service = new dotlog.model.service.airportService(DAO, GW);
				break;
			case "categoryService":
				DAO = new dotlog.model.dataAccess.categoryDAO(variables.instance.datasource);
				GW = new dotlog.model.dataAccess.categoryGateway(variables.instance.datasource);
				service = new dotlog.model.service.categoryService(DAO, GW);
				break;
			case "recordService":
				DAO = new dotlog.model.dataAccess.recordDAO(variables.instance.datasource);
				GW = new dotlog.model.dataAccess.recordGateway(variables.instance.datasource);
				service = new dotlog.model.service.recordService(DAO, GW);
				break;
			case "userService":
				DAO = new dotlog.model.dataAccess.userDAO(variables.instance.datasource);
				GW = new dotlog.model.dataAccess.userGateway(variables.instance.datasource);
				service = new dotlog.model.service.userService(DAO, GW);
				break;
			case "reportService":
				DAO = new dotlog.model.dataAccess.reportDAO(variables.instance.datasource);
				GW = new dotlog.model.dataAccess.reportGateway(variables.instance.datasource);
				service = new dotlog.model.service.reportService(DAO, GW);
				break;
			case "regionService":
				DAO = new dotlog.model.dataAccess.regionDAO(variables.instance.datasource);
				GW = new dotlog.model.dataAccess.regionGateway(variables.instance.datasource);
				service = new dotlog.model.service.regionService(DAO, GW);
				break;
			case "districtService":
				DAO = new dotlog.model.dataAccess.districtDAO(variables.instance.datasource);
				GW = new dotlog.model.dataAccess.districtGateway(variables.instance.datasource);
				service = new dotlog.model.service.districtService(DAO, GW);
				break;
		}
		return service;
	}
}