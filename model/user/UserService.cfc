<cfcomponent displayname="User Service" output="false">
    <!--- Author: gregstewart - Date: 5/22/2007 --->
	<cffunction name="init" output="false" access="public" returntype="UserService" hint="I initialise the service">
	    <cfargument name="transfer" type="WEB-INF.cftags.component" required="true" />
        
        <cfset variables.transfer = arguments.transfer/>
        
        <cfreturn this/>
    </cffunction>
    
	<cffunction name="getUser" access="public" output="false" returntype="any">
		<cfargument name="userID" type="numeric" required="false" default="0" />
		<cfset var user = variables.transfer.get("user.User",arguments.userID) />
		
		<cfreturn user />
	</cffunction>
    
    <!--- Author: gregstewart - Date: 6/4/2007 --->
	<cffunction name="set" output="false" access="public" returntype="WEB-INF.cftags.component" hint="I create/update a project">
	    <cfargument name="userId" type="numeric" required="true" />
	    <cfargument name="firstName" type="string" required="true" />
        <cfargument name="lastName" type="string" required="true" />
        <cfargument name="email" type="string" required="true" />
        <cfargument name="username" type="string" required="true" />
        <cfargument name="password" type="string" required="true" />
                    
        <cfset var user = ""/>
        
        <cftry>
	        <cfif arguments.userId eq 0>
	            <cfset user = variables.transfer.new("user.User")/>
                <cfset user.setFirstName(arguments.firstName)/>
                <cfset user.setLastName(arguments.lastName)/>
                <cfset user.setEmail(arguments.email)/>
                <cfset user.setUserName(arguments.username)/>
	            <cfset user.setPassword(arguments.password)/>
	            <cfset user.setDateAdded(now())/>
	        <cfelse>
                <cfset user = variables.transfer.get("user.User",arguments.userId)/>
	            <cfset user.setFirstName(arguments.firstName)/>
                <cfset user.setLastName(arguments.lastName)/>
                <cfset user.setEmail(arguments.email)/>
                <cfset user.setUserName(arguments.username)/>
	            <cfset user.setPassword(arguments.password)/>
	        </cfif>

            <cfset variables.transfer.save(user)/>
            
            <cfcatch type="any">
                <cfdump var="#cfcatch#"/><cfabort />
            </cfcatch>
        </cftry>
        
        <cfreturn user/>
	</cffunction>
</cfcomponent>