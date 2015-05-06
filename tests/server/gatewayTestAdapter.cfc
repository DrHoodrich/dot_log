component GatewayTestAdapter
{
	variables.gatewayObject = '';

	public DAOTestAdapter function init(required dotlog.model.dataAccess.gateway GW)
	{
		variables.gatewayObject = arguments.GW;
		return this;
	}

	public any function filter(required struct searchParameters) //TODO: figure a way to return proper objects for DB
	{
		//TODO
	}
}