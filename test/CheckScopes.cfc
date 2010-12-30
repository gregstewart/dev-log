<cfcomponent name="CheckScopes" hint="I check all scopes" extends="org.cfcunit.framework.TestCase">

	<cffunction name="testCheckScopes" returntype="void" access="public" output="false">  
		<cfset var varScopeChecker = CreateObject("component","stubbie.VarScopeChecker.VarScopeChecker")>
		<cfset var aErrors = varScopeChecker.check( "/Applications/JRun4/servers/cfusion/cfusion-ear/cfusion-war/devLog" ) />		
		<cfset var isEmpty = evaluate("ArrayLen(aErrors) eq 0") />
		<cfset var message = "#arrayLen( aErrors )# local variable(s) were not var scoped. DETAILS: #aErrors.toString()#" />
		
		<cfset assertEqualsBoolean(true, isEmpty, message) />
	</cffunction>

</cfcomponent>
