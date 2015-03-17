<cfscript>
component User {
        //property name = "user_name" type = "string";
        /*
        public User function init()
        {
                return this;
                //variables.Instance.name = name;
        }
        */

        variables.full_name = "";

        public User function init(required string name)
        {
                full_name = arguments.name;
                return this;
        }

        public string function getName() 
        {
                return variables.full_name;
        }

        public string function getInitials()
        {
                return "B. D.";
        }




}
</cfscript>