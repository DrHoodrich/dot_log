 <!-- BEGIN MENU -->   
 	<div id="menu"> 
  	  <ul id="nav" class="dropdown dropdown-horizontal">
		<!-- TemplateBeginEditable name="Dropdown Menu" -->
		<li><a href="/dotlog/pages/add_event.cfm">Add Event</a></li>
	    <li><a href="/dotlog/pages/search.cfm">Search</a></li>
        <li class="dir"><a href="/dotlog/pages/report_daily.cfm">Reporting</a>
        	<ul>
        		<li><a href="/dotlog/pages/report_daily.cfm">Daily</a></li>
        		<li><a href="/dotlog/pages/report_weekly.cfm">Weekly</a></li>
        	</ul>
        </li>
        <cfif session.user.getPermissions()>
		<li class="dir"><a href="/dotlog/pages/add_user.cfm">Users</a>
			<ul>
					<li><a href="/dotlog/pages/add_user.cfm">Add User</a></li>
					<li><a href="/dotlog/pages/edit_user.cfm">Edit Users</a></li>
				</ul>
			</li>
			<li class="dir"><a href="/dotlog/pages/add_category.cfm">Categories</a>
	        	<ul>
					<li><a href="/dotlog/pages/add_category.cfm">Add Category</a></li>
					<li><a href="/dotlog/pages/edit_category.cfm">Edit Category</a></li>
				</ul>
			</li>
			<li class="dir"><a href="/dotlog/pages/add_airport.cfm">Airports</a>
	        	<ul>
					<li><a href="/dotlog/pages/add_airport.cfm">Add Airport</a></li>
					<li><a href="/dotlog/pages/edit_airport.cfm">Edit Airport</a></li>
				</ul>
			</li>
			<li class="dir"><a href="/dotlog/pages/add_district.cfm">Districts</a>
	        	<ul>
					<li><a href="/dotlog/pages/add_district.cfm">Add District</a></li>
					<li><a href="/dotlog/pages/edit_district.cfm">Edit District</a></li>
				</ul>
			</li>
			<li class="dir"><a href="/dotlog/pages/add_region.cfm">Regions</a>
	        	<ul>
					<li><a href="/dotlog/pages/add_region.cfm">Add Region</a></li>
					<li><a href="/dotlog/pages/edit_region.cfm">Edit Region</a></li>
				</ul>
			</li>
			<cfelse>
			<li class="dir"><a href="/dotlog/pages/category_help.cfm">Category Help</a></li>
		</cfif>
	    <!-- TemplateEndEditable -->
	  </ul>
	</div>
<!-- END MENU -->