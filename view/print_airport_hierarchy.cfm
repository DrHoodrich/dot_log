<cfffunction name="printRecords"(required array records)
	{
		<cfselect name = "parentAirportCode">
					<option value=""> --Select Region/Hub-- </option>
					<cfscript>
						writeOutput('<option style="font-weight:bold;" value="Statewide"><strong>AK Statewide</strong></option>');
						for (ii = 1; ii <= arrayLen(regionAirports); ++ii) {
							writeOutput('<option></option>');
				    		writeOutput('<option value="#regionAirports[ii].getAirportCode()#">--#regionAirports[ii].getAirportName()#--</option>');
				    		tmpArray = hubAirports[ii];
				    		for (md = 1; md <= arrayLen(tmpArray); ++md) {
				    			writeOutput('<option value="#hubAirports[ii][md].getAirportCode()#">#hubAirports[ii][md].getAirportCode()#  --  #hubAirports[ii][md].getAirportName()# </option>');
				  			}
				  		}   
					</cfscript>
				</cfselect>
	}
</cfscript>