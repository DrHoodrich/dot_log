component Airport
{
    variables.instance = {
        FAAcode = '', 
        parentFAACode = '',
        airportName = '',
        enabled = ''
    };

        public Airport function init(required string FAAcode,
                                        required string parentFAACode,
                                        required string airportName,
                                        required numeric enabled)
        {
               variables.instance.FAACode = arguments.FAACode;
               variables.instance.parentFAACode = arguments.parentFAACode;
               variables.instance.airportName = arguments.airportName;
               variables.instance.enabled = arguments.enabled;
               return this;
        }

        public string function getFAACode()
        {
                return variables.instance.FAAcode;
        }

        public string function getParentAirportFAACode()
        {
                return variables.instance.parentFAACode;
        }

        public string function getAirportName()
        {
                return variables.instance.airportName;
        }

        public boolean function isEnabled() 
        {
                return variables.instance.enabled;
        }
}