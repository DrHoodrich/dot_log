<cfscript>
	testSuite = new mxunit.framework.TestSuite();
	testSuite.addAll( "spec.user_tests" );
	testSuite.addAll( "spec.datasource_tests" );
	testSuite.addAll( "spec.userDAO_tests" );
	testSuite.addAll( "spec.record_tests" );
	testSuite.addAll( "spec.category_tests" );
	testSuite.addAll( "spec.airport_tests" );
	testResults = testSuite.run();
	writeOutput(testResults.getHtmlResults( "../mxunit/" ));
</cfscript>