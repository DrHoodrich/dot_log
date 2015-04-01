<cfscript>
	testSuite = new mxunit.framework.TestSuite();
	testSuite.addAll( "spec.user_tests" );
	testSuite.addAll( "spec.datasource_tests" );
	testSuite.addAll( "spec.userDAO_tests" );
	testResults = testSuite.run();
	writeOutput(testResults.getHtmlResults( "../mxunit/" ));
</cfscript>