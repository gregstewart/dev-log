<cfcomponent displayname="Login Manager" hint="I manage all aspects of accessing the app" output="false">
    <!--- Author: gregstewart - Date: 5/21/2007 --->
	<cffunction name="init" output="false" access="public" returntype="LoginManager" hint="I initialise the application">
	    <cfargument name="transfer" type="WEB-INF.cftags.component" required="true" />
        
        <cfset variables.transfer = arguments.transfer/>
        
        <cfreturn this/>
    </cffunction>
    
    <!--- Author: gregstewart - Date: 5/23/2007 --->
	<cffunction name="attemptLogin" output="false" access="public" returntype="WEB-INF.cftags.component" hint="">
	    <cfargument name="username" type="string" required="true" />
        <cfargument name="password" type="string" required="true" />
        <cfargument name="user" type="WEB-INF.cftags.component" required="true" />
        
        <cfset var qUser = ""/>
        <cfset var propertyMap = StructNew()/>
        
        <cfscript>
            propertyMap.username = arguments.username;
            propertyMap.password = arguments.password;
        </cfscript>
        
        <cfset qUser = variables.transfer.readByPropertyMap("user.User",propertyMap)/>
        <cfset arguments.user.setTransferObject(qUser)/>
        <cfreturn arguments.user>
    </cffunction>
</cfcomponent>