<cfcomponent name="AllTests" extends="org.cfcunit.Object" output="false" hint="Runs all unit tests in package.">
    
    <cffunction name="suite" returntype="org.cfcunit.framework.Test" access="public" output="false" hint="">
        <cfset var testSuite = newObject("org.cfcunit.framework.TestSuite").init("All cfcUnit Tests") />
        
            
        <cfset testSuite.addTestSuite(newObject("devLog.test.model.LoggerTest")) />
            
        <cfset testSuite.addTestSuite(newObject("devLog.test.model.LoginManagerTest")) />
            
        <cfset testSuite.addTestSuite(newObject("devLog.test.model.SecurityServiceTest")) />
            
        <cfset testSuite.addTestSuite(newObject("devLog.test.model.data.Gateway.LoggerGatewayTest")) />
            
        <cfset testSuite.addTestSuite(newObject("devLog.test.model.project.ProjectManagerTest")) />
            
        <cfset testSuite.addTestSuite(newObject("devLog.test.model.user.UserBeanTest")) />
            
        <cfset testSuite.addTestSuite(newObject("devLog.test.model.user.UserServiceTest")) />
            
        <cfset testSuite.addTestSuite(newObject("devLog.test.CheckScopes")) />
            
        <cfreturn testSuite/>
	</cffunction>	

</cfcomponent>
