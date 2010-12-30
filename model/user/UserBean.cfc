<cfcomponent displayname="User Bean" output="false">
    <!--- Author: gregstewart - Date: 5/23/2007 --->
	<cffunction name="init" output="false" access="public" returntype="UserBean" hint="">
        <cfargument name="transferUser" type="any" required="false" default="" />
        <cfargument name="isLoggedIn" type="boolean" required="false" default="false" />
        
        <cfscript>
            variables.my = StructNew();
            variables.my.Errors = ArrayNew(1);
            //setTransferObject(arguments.transferUser);
            setIsLoggedIn(arguments.isLoggedIn);
        </cfscript>
        
        <cfreturn this/>
    </cffunction>
    
    <!--- Author: gregstewart - Date: 5/23/2007 - getter and setter for TransferObject --->
	<cffunction name="getTransferObject" access="public" output="false" returntype="WEB-INF.cftags.component">
		<cfreturn variables.my.TransferObject/>
	</cffunction>
	<cffunction name="setTransferObject" access="public" output="false" returntype="void">
		<cfargument name="TransferObject" type="WEB-INF.cftags.component" required="true" />
		<cfset variables.my.TransferObject = arguments.TransferObject />
	</cffunction>
    
    <!--- Author: gregstewart - Date: 5/23/2007 - getter and setter for IsLoggedIn --->
	<cffunction name="getIsLoggedIn" access="public" output="false" returntype="boolean">
		<cfreturn variables.my.IsLoggedIn/>
	</cffunction>
	<cffunction name="setIsLoggedIn" access="public" output="false" returntype="void">
		<cfargument name="IsLoggedIn" type="boolean" required="true" />
		<cfset variables.my.IsLoggedIn = arguments.IsLoggedIn />
	</cffunction>

    <!--- Author: gstewart - Date: 5/24/2007 - getter and setter for Errors --->
	<cffunction name="getErrors" access="public" output="false" returntype="array">
		<cfreturn variables.my.Errors/>
	</cffunction>
	<cffunction name="setError" access="public" output="false" returntype="void">
		<cfargument name="Error" type="string" required="true" />
		<cfset ArrayAppend(variables.my.Errors,arguments.Error) />
	</cffunction>
    <!--- Author: gstewart - Date: 5/24/2007 --->
	<cffunction name="clearErrors" output="false" access="public" returntype="void" hint="I clear the error struct">
		<cfset variables.my.errors = ArrayNew(1)/>
	</cffunction>
</cfcomponent>