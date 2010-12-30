<cfcomponent displayname="Client Manager" hint="I manage clients" output="false">
    <!--- Author: gregstewart - Date: 5/22/2007 --->
	<cffunction name="init" output="false" access="public" returntype="ClientManager" hint="I initialise the component">
	    <cfargument name="transfer" type="WEB-INF.cftags.component" required="true" />
        
        <cfset variables.transfer = arguments.transfer/>
        
        <cfreturn this/>
    </cffunction>
    
    <!--- Author: gregstewart - Date: 6/4/2007 --->
	<cffunction name="set" output="false" access="public" returntype="WEB-INF.cftags.component" hint="I create/update a client">
	    <cfargument name="userId" type="numeric" required="true" />
	    <cfargument name="formValues" type="Struct" required="true" />
                    
        <cfset var user = ""/>
        <cfset var client = ""/>
        
        <cftry>
	        <cfif arguments.formValues.client_id eq 0>
	            <cfset client = variables.transfer.new("client.Client")/>
                <cfset client.setName(arguments.formValues.name)/>
	            <!--- <cfset client.setUser_id(arguments.userId)/> --->
	        <cfelse>
                <cfset client = variables.transfer.get("client.Client",arguments.formValues.client_id)/>
	            <cfset client.setName(arguments.formValues.name)/>
	            <!--- <cfset client.setUser_id(arguments.userId)/> --->
	        </cfif>
            <cfset user = variables.transfer.get("user.User", arguments.userId)/>
            <cfset client.addClientUserRel(user)/>
            <cfset variables.transfer.save(client)/>
            
            <cfcatch type="any">
                <cfdump var="#cfcatch#"/><cfabort />
            </cfcatch>
        </cftry>
        
        <cfreturn client/>
	</cffunction>
    
    <!--- Author: gregstewart - Date: 6/4/2007 --->
	<cffunction name="get" output="false" access="public" returntype="WEB-INF.cftags.component" hint="">
	    <cfargument name="clientId" type="numeric" required="true" />
	    
	    <cfif arguments.clientId eq 0>
	        <cfreturn variables.transfer.new("client.Client")/>
	    <cfelse>
	        <cfreturn variables.transfer.get("client.Client",arguments.clientID)/>
	    </cfif>
	</cffunction>
</cfcomponent>