<cfinvoke component="mxunit.runner.DirectoryTestSuite"
          method="run"
          directory="#expandPath('/dotlog/tests/server')#"
          componentPath=""
          recurse="true"
          excludes="InvalidMarkupTest,FiveSecondTest"
          returnvariable="results" />
<cfoutput> #results.getResultsOutput('extjs')# </cfoutput>
