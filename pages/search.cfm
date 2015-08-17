<cfset pageTitle = "Search"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/view/header.cfm">
<cfoutput><h2>#pageTitle#</h2></cfoutput>
<cfscript>
	airports = application.airportService.getSpokeAirports(session.user.getAirportCode());
	categories = application.categoryService.getAllCategories();
</cfscript>
<cfform name="search" action="search_action.cfm" method="post">
	<table>
		<tr>
			<td>Keyword</td>
			<td><cfinput type = "text" name = "keyword" message = "" required = "no"/></td>
			
		</tr>
		<tr>
			<td>Username</td>
			<td><cfinput type = "text" name = "username" message = "" required = "no"/></td>
			
		</tr>
		<tr>
			<td>Airport</td>
			<td>
				<cfselect name="airportCode" id="airportCode">
					<option value=""></option>
					<cfloop array="#airports#" index="airport">
						<cfoutput><option value="#airport.getAirportCode()#">#airport.getAirportCode()# - #airport.getAirportName()#</option></cfoutput>
					</cfloop>
				</cfselect>
			</td>
			
		</tr>
		<tr>
			<td>Category</td>
			<td>
				<cfselect name="categoryTitle" id="categoryTitle">					
					<option value=""></option>
					<cfloop array="#categories#" index="category">
						<cfoutput><option value="#category.getCategoryTitle()#">#category.getCategoryTitle()#</option></cfoutput>
					</cfloop>					
				</cfselect>
			</td>
		</tr>
		<tr>
			<td>Start Date</td>
			<td><cfinput type="datefield" name="startDate" message=""/></td>
			<td><strong>and</strong></td>
			<td>End Date</td>
			<td><cfinput type="datefield" name="endDate" message=""/></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td><cfinput type="submit" name="submitSearch_button" id="searchRecords" value="Search"></td>
		</tr>
	</table>
</cfform>
<cfinclude template="/dotlog/includes/footer.cfm">