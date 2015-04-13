component extends = "taffy.core.resource" taffy_uri="/api/events"
{
	DSName = "DOTlogDB";
	DSuser = " ";
	DSpasswd = " ";
	datasource = new dotlog.components.datasource(DSName, DSuser, DSpasswd);
	categoryDAO = new dotlog.components.categoryDAO(datasource);

	function put(required array EVENTS)
	{	
		if (!arrayIsEmpty(events)) {
			FileWrite("c:/test.txt", events[1].FAA_CODE & " " & events[1].category_title & " " & events[1].in_weekly_report & " " & events[1].event_time & " " & events[1].event_text);
		}
		return representationOf(getMetadata(events)).withStatus(200);
	}
}