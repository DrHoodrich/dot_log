<cfset pageTitle = "Add Category"> <!--- Variable that is used in the html included header --->
<cfinclude template="/dotlog/view/header.cfm">
<cfoutput><h2>#pageTitle#</h2></cfoutput>
<cfform name="addCategory" action="saveCategory.cfm" method="post">

  <cfinput type="hidden" name="enabled" value="1"/>
  
  <table>
		<tr>
			<td>Category Title</td>
			<td><cfinput name="categoryTitle" type="text"/></td>
		</tr>
		<tr>
			<td>Category Description</td>
			<td><cftextarea name="description" cols="40" rows="5"/></td>
		</tr>
		<tr>
			<td>Automatically In Weekly Report</td>
			<td><cfinput type="checkbox" name="inWeeklyReport" required="no" value="1"/></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td><cfinput type="submit" name="addCategory_button" value="Add Category"/></td>
		</tr>
	</table>
</cfform>

<cfinclude template="/dotlog/includes/footer.cfm">