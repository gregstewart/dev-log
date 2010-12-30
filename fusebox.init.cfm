<!---
	fusebox.init.cfm is included by the framework at the start of every request.
	It is included within a cfsilent tag so it cannot generate output. It is
	intended to be for per-request initialization and manipulation of the
	Fusebox fuseaction variables.
	
	You can set attributes.fuseaction, for example, to override the default
	fuseaction.
	
	A typical usage is to set "self" and "myself" variables, as shown below,
	for use inside display fuses when creating links.
--->
<cfset self = "index.cfm" />
<cfset myself = "#self#?#myFusebox.getApplication().fuseactionVariable#=" />

<cfif StructKeyExists(url,"clear")>
    <cfset StructClear(session)/>
</cfif>

<!--- session initialization --->
<cfif not structKeyExists(session,"user")>
	<cflock scope="session" type="exclusive" timeout="10">
		<cfif not structKeyExists(session,"user")>
			<cfset session.user = createObject("component","devLog.model.user.UserBean").init() />
		</cfif>
	</cflock>
</cfif>