<cfscript>
	testSuite = new mxunit.framework.TestSuite();
	testSuite.addAll( "model.dataAccess.airportDAO_tests" );
	testSuite.addAll( "model.beans.airport_tests" );
	testSuite.addAll( "model.dataAccess.categoryDAO_tests" );
	testSuite.addAll( "model.beans.category_tests" );
	testSuite.addAll( "model.beans.datasource_tests" );
	testSuite.addAll( "model.dataAccess.recordDAO_tests" );
	testSuite.addAll( "model.service.recordService_tests" );
	testSuite.addAll( "model.beans.record_tests" );
	testSuite.addAll( "model.dataAccess.reportDAO_tests" );
	testSuite.addAll( "model.beans.report_tests" );
	testSuite.addAll( "model.dataAccess.userDAO_tests" );
	testSuite.addAll( "model.beans.user_tests" );
	testResults = testSuite.run();
	writeOutput(testResults.getHtmlResults( "../mxunit/" ));
</cfscript>
