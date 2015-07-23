<cfset pageTitle = "Search"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/view/header.cfm">
	
<!-- BEGIN YOUR CONTENT HERE -->
  <!-- TemplateBeginEditable name="main content" -->
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
			<td>LDAP User</td>
			<td><cfinput type = "text" name = "username" message = "" required = "no"/></td>
			
		</tr>
		<!---
		<tr>
			<td>First Name</td>
			<td><cfinput type = "text" name = "firstName" message = "" required = "no"/></td>
			
		</tr>
		<tr>
			<td>Last Name</td>
			<td><cfinput type = "text" name = "lastName" message = "" required = "no"/></td>
			
		</tr>
		--->
		<tr>
			<td>Airport</td>
			<td>
				<cfselect name="airportCode" id="airportCode">
					<cfscript>
						writeOutput('<option value=""></option>');
						writeOutput('<option value=#session.user.getAirportCode()#>#session.user.getAirportCode()#</option>');
						for (ii = 1; ii <= arrayLen(airports); ++ii) {
							writeOutput('<option value=#airports[ii].getAirportCode()#>#airports[ii].getAirportCode()&' - '&airports[ii].getAirportName()#</option>');
						}
					</cfscript>
				</cfselect>
			</td>
			
		</tr>
		<tr>
			<td>Category</td>
			<td>
				<cfselect name="categoryTitle" id="categoryTitle">
					<cfscript>
						writeOutput('<option value=""></option>');
						for (ii = 1; ii <= arrayLen(categories); ++ii) {
							writeOutput('<option value=#categories[ii].getCategoryTitle()#>#categories[ii].getCategoryTitle()#</option>');
						}
					</cfscript>
				</cfselect>
			</td>
			
		</tr>
		<tr>
			<td>Start Date</td>
			<td><cfinput type="datefield" name="startDate" message=""/></td>
		</tr>
		<tr>
			<td>End Date</td>
			<td><cfinput type="datefield" name="endDate" message=""/></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td><cfinput type="submit" name="submitSearch_button" id="searchRecords" value="Search"></td>
		</tr>
	</table>
</cfform>
  <!-- TemplateEndEditable -->
<!-- END YOUR CONTENT HERE -->
<cfinclude template="/dotlog/includes/footer.cfm">