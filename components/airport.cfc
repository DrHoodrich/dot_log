component Airport
{
        property name="FAAcode" type="string" default="" hint=""; 
        property name="parentFAACode" type="string" default="" hint="";
        property name="airportName" type="string" default="" hint="";
        property name="enabled" type="numeric" default="" hint="";

        public Airport function init(required string FAAcode,
                                        required string parentFAACode,
                                        required string airportName,
                                        required numeric enabled)
        {
               variables.FAACode = arguments.FAACode;
               variables.parentFAACode = arguments.parentFAACode;
               variables.airportName = arguments.airportName;
               variables.enabled = arguments.enabled;
               return this;
        }

        public string function getFAACode()
        {
                return variables.FAAcode;
        }

        public string function getParentAirportFAACode()
        {
                return variables.parentFAACode;
        }

        public string function getAirportName()
        {
                return variables.airportName;
        }

        public boolean function isEnabled() 
        {
                return variables.enabled;
        }
}