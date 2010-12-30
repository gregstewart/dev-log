<cfcomponent displayname="Sinup Service" output="false">
    <!--- Author: gregstewart - Date: 5/21/2007 --->
	<cffunction name="init" output="false" access="public" returntype="SignupService" hint="I initialise the component">
	    <cfargument name="userService" type="WEB-INF.cftags.component" required="true" />
        <cfargument name="loginManager" type="WEB-INF.cftags.component" required="true" />
        
        <cfset variables.userService = arguments.userService/>
        <cfset variables.loginManager = arguments.loginManager/>
        
        <cfreturn this/>
    </cffunction>
    
    <!--- Author: gregstewart - Date: 5/23/2007 --->
	<cffunction name="do" output="false" access="public" returntype="devLog.model.user.UserBean" hint="">
	    <cfargument name="firstname" type="string" required="true" />
        <cfargument name="lastname" type="string" required="true" />
        <cfargument name="email" type="string" required="true" />
        <cfargument name="username" type="string" required="true" />
        <cfargument name="password" type="string" required="true" />
        <cfargument name="user" type="devLog.model.user.UserBean" required="true" />
        
        <cfset arguments.user.clearErrors()/>
        
        <!--- validate credentials --->
        <cfif arguments.firstname eq "">
            <cfset arguments.user.setError("Please specify a first name")/>
        </cfif>
        
        <cfif arguments.lastname eq "">
            <cfset arguments.user.setError("Please specify a last name")/>
        </cfif>
        
        <cfif arguments.email eq "">
            <cfset arguments.user.setError("Please specify an email address")/>
        <cfelse>
            <cfif NOT hasValidEmail(arguments.email)>
                <cfset arguments.user.setError("Please specify a valid email address")/>
            </cfif>
        </cfif>
        
        <cfif arguments.username eq "">
            <cfset arguments.user.setError("Please specify a username")/>
        </cfif>
        
        <cfif arguments.password eq "">
            <cfset arguments.user.setError("Please specify a password")/>
        </cfif>
       

        <!--- TODO: validate that no one is trying to pass in an insert query as credentials --->
        <cfif ArrayLen(arguments.user.getErrors()) eq 0>
            <cfset arguments.user.setTransferObject(variables.userService.set(0,arguments.firstname,arguments.lastname,arguments.email,arguments.username,arguments.password))/>
            
            <cfif arguments.user.getTransferObject().getId() neq 0>
                <cfset arguments.user.setIsLoggedIn(true)/>
            </cfif>
        </cfif>
        
        <cfreturn arguments.user />
    </cffunction>
    
    <!--- Author: gregstewart - Date: 7/23/2007 --->
	<cffunction name="hasValidEmail" output="false" access="public" returntype="boolean" hint="I validate the email address">
	    <cfargument name="email" type="string" required="true" />
                    
        <cfscript>
		/**
		 * Tests passed value to see if it is a valid e-mail address (supports subdomain nesting and new top-level domains).
		 * Update by David Kearns to support '
		 * SBrown@xacting.com pointing out regex still wasn't accepting ' correctly.
		 * More TLDs
		 * Version 4 by P Farrel, supports limits on u/h
		 * 
		 * @param str 	 The string to check. (Required)
		 * @return Returns a boolean. 
		 * @author Jeff Guillaume (SBrown@xacting.comjeff@kazoomis.com) 
		 * @version 4, December 30, 2005 
		 */
		    return (REFindNoCase("^['_a-z0-9-]+(\.['_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*\.(([a-z]{2,3})|(aero|coop|info|museum|name|jobs|travel))$",arguments.email) AND len(listGetAt(arguments.email, 1, "@")) LTE 64 AND len(listGetAt(arguments.email, 2, "@")) LTE 255) IS 1;
		</cfscript>

    </cffunction>
        
    <!--- Author: gregstewart - Date: 5/24/2007 --->
	<cffunction name="clearErrors" output="false" access="public" returntype="devLog.model.user.UserBean" hint="">
	    <cfargument name="user" type="devLog.model.user.UserBean" required="true" />
	    
	    <cfset arguments.user.clearErrors()/>
        
	    <cfreturn arguments.user/>
	</cffunction>
</cfcomponent>