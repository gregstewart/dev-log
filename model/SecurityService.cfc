<cfcomponent displayname="Security Service" output="false">
    <!--- Author: gregstewart - Date: 5/22/2007 --->
	<cffunction name="init" output="false" access="public" returntype="SecurityService" hint="I initialise the SecurityService">
	    <cfargument name="loginManager" type="WEB-INF.cftags.component" required="true" />
  
        <cfset variables.loginManager = arguments.loginManager>                  
        
        <cfreturn this/>
    </cffunction>
    
    <!--- Author: gregstewart - Date: 5/22/2007 --->
	<cffunction name="isLoggedIn" output="false" access="public" returntype="boolean" hint="">
	    <cfargument name="session" type="struct" required="true" />
        
        <cfif StructKeyExists(arguments.session,"user") AND arguments.session.user.getIsLoggedIn()>
            <cfreturn true/>
        </cfif>
        
        <cfreturn false/>
    </cffunction>
    
    <!--- Author: gregstewart - Date: 5/22/2007 --->
	<cffunction name="logout" output="false" access="public" returntype="devLog.model.user.UserBean" hint="I log a user out by replacing the user bean">
	    <cfargument name="user" type="struct" required="true" />
        
        <cfset arguments.user = createObject("component","devLog.model.user.UserBean").init()/>
        
        <cfreturn arguments.user/>
    </cffunction>
    
    <!--- Author: gregstewart - Date: 5/23/2007 --->
	<cffunction name="authenticate" output="false" access="public" returntype="devLog.model.user.UserBean" hint="">
	    <cfargument name="username" type="string" required="true" />
        <cfargument name="password" type="string" required="true" />
        <cfargument name="user" type="devLog.model.user.UserBean" required="true" />
        
        <!--- validate credentials --->
        <cfif arguments.username eq "" OR arguments.password eq "">
            <cfset arguments.user.setError("Please specify both a username and password")/>
        </cfif>
        <!--- TODO: validate that no one is trying to pass in an insert query as credentials --->
        <cfif ArrayLen(arguments.user.getErrors()) eq 0>
            <cfset arguments.user=variables.loginManager.attemptLogin(arguments.username, arguments.password, arguments.user)/>
            
            <cfif arguments.user.getTransferObject().getId() neq 0>
                <cfset arguments.user.setIsLoggedIn(true)/>
            <cfelse>
                <cfset arguments.user.setError("The username/password combination you provided doesn't appear to be right.")/>
            </cfif>
        </cfif>
        
        <cfreturn arguments.user />
    </cffunction>
    
    <!--- Author: gregstewart - Date: 5/24/2007 --->
	<cffunction name="clearErrors" output="false" access="public" returntype="devLog.model.user.UserBean" hint="">
	    <cfargument name="user" type="devLog.model.user.UserBean" required="true" />
	    
	    <cfset arguments.user.clearErrors()/>
        
	    <cfreturn arguments.user/>
	</cffunction>
</cfcomponent>