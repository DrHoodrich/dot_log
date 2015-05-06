<cfscript>
	testSuite = new mxunit.framework.TestSuite();
	testSuite.addAll( "model.airportDAO_tests" );
	testSuite.addAll( "model.airport_tests" );
	testSuite.addAll( "model.categoryDAO_tests" );
	testSuite.addAll( "model.category_tests" );
	testSuite.addAll( "model.datasource_tests" );
	testSuite.addAll( "model.recordDAO_tests" );
	testSuite.addAll( "model.recordService_tests" );
	testSuite.addAll( "model.record_tests" );
	testSuite.addAll( "model.reportDAO_tests" );
	testSuite.addAll( "model.report_tests" );
	testSuite.addAll( "model.userDAO_tests" );
	testSuite.addAll( "model.user_tests" );
	testResults = testSuite.run();
	writeOutput(testResults.getHtmlResults( "../mxunit/" ));
</cfscript>
