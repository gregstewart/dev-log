<cfsetting enablecfoutputonly="true" />
<cfprocessingdirective pageencoding="utf-8" />
<!--- circuit: app --->
<!--- fuseaction: editLogEntry --->
<cftry>
<cfset myFusebox.thisPhase = "appinit">
<cfset myFusebox.thisCircuit = "app">
<cfset myFusebox.thisFuseaction = "editLogEntry">
<cfif myFusebox.applicationStart>
	<cfif not myFusebox.getApplication().applicationStarted>
		<cflock name="#application.ApplicationName#_fusebox_#FUSEBOX_APPLICATION_KEY#_appinit" type="exclusive" timeout="30">
			<cfif not myFusebox.getApplication().applicationStarted>
<!--- fuseaction action="app.initialize" --->
<cfset myFusebox.trace("Runtime","&lt;fuseaction action=""app.initialize""/&gt;") >
<cfset myFusebox.thisFuseaction = "initialize">
<cfif myfusebox.thisFuseaction neq 'initialize'>
<!--- do action="login.isLoggedIn" --->
<cfset myFusebox.trace("Runtime","&lt;do action=""login.isLoggedIn""/&gt;") >
<cfset myFusebox.thisCircuit = "login">
<cfset myFusebox.thisFuseaction = "isLoggedIn">
<cfset variables.securityService = myFusebox.getApplication().getApplicationData().servicefactory.getBean(beanName="securityService")/> 
<cfset attributes.isLoggedIn = variables.securityService.isLoggedIn(session) >
<cfif NOT attributes.isLoggedIn>
<cflocation url="#variables.mySelf#login.show" addtoken="false">
<cfabort>
</cfif>
<cfset myFusebox.thisCircuit = "app">
<cfset myFusebox.thisFuseaction = "initialize">
</cfif>
<cfset myFusebox.getApplication().getApplicationData().servicefactory = createObject("component", "coldspring.beans.DefaultXmlBeanFactory").init( defaultProperties="#structnew()#" )/>
<cfset myFusebox.getApplication().getApplicationData().servicefactory.loadBeansFromXmlFile(beanDefinitionFile="#expandPath('config/cs.xml')#") />
<cfset myFusebox.thisFuseaction = "editLogEntry">
				<cfset myFusebox.getApplication().applicationStarted = true />
			</cfif>
		</cflock>
	</cfif>
</cfif>
<cfset myFusebox.thisPhase = "requestedFuseaction">
<cfif myfusebox.thisFuseaction neq 'initialize'>
<!--- do action="login.isLoggedIn" --->
<cfset myFusebox.trace("Runtime","&lt;do action=""login.isLoggedIn""/&gt;") >
<cfset myFusebox.thisCircuit = "login">
<cfset myFusebox.thisFuseaction = "isLoggedIn">
<cfset variables.securityService = myFusebox.getApplication().getApplicationData().servicefactory.getBean(beanName="securityService")/> 
<cfset attributes.isLoggedIn = variables.securityService.isLoggedIn(session) >
<cfif NOT attributes.isLoggedIn>
<cflocation url="#variables.mySelf#login.show" addtoken="false">
<cfabort>
</cfif>
<cfset myFusebox.thisCircuit = "app">
<cfset myFusebox.thisFuseaction = "editLogEntry">
</cfif>
<cfif NOT StructKeyExists(attributes,'submit')>
<!--- do action="logEntry" --->
<cfset myFusebox.trace("Runtime","&lt;do action=""logEntry""/&gt;") >
<cfset myFusebox.thisFuseaction = "logEntry">
<cfif myfusebox.thisFuseaction neq 'initialize'>
<!--- do action="login.isLoggedIn" --->
<cfset myFusebox.trace("Runtime","&lt;do action=""login.isLoggedIn""/&gt;") >
<cfset myFusebox.thisCircuit = "login">
<cfset myFusebox.thisFuseaction = "isLoggedIn">
<cfset variables.securityService = myFusebox.getApplication().getApplicationData().servicefactory.getBean(beanName="securityService")/> 
<cfset attributes.isLoggedIn = variables.securityService.isLoggedIn(session) >
<cfif NOT attributes.isLoggedIn>
<cflocation url="#variables.mySelf#login.show" addtoken="false">
<cfabort>
</cfif>
<cfset myFusebox.thisCircuit = "app">
<cfset myFusebox.thisFuseaction = "logEntry">
</cfif>
<cfif not isDefined("attributes.log_id")><cfset attributes.log_id = "0" /></cfif>
<cfif not isDefined("attributes.client_id")><cfset attributes.client_id = "0" /></cfif>
<cfif not isDefined("attributes.project_id")><cfset attributes.project_id = "0" /></cfif>
<cfset variables.logger = myFusebox.getApplication().getApplicationData().servicefactory.getBean(beanName="logger")/> 
<cfset variables.logEntry = variables.logger.getEntry(session.user.getTransferObject().getId(),attributes.log_id,attributes.client_id,attributes.project_id) >
<!--- do action="getClients" --->
<cfset myFusebox.trace("Runtime","&lt;do action=""getClients""/&gt;") >
<cfset myFusebox.thisFuseaction = "getClients">
<cfif myfusebox.thisFuseaction neq 'initialize'>
<!--- do action="login.isLoggedIn" --->
<cfset myFusebox.trace("Runtime","&lt;do action=""login.isLoggedIn""/&gt;") >
<cfset myFusebox.thisCircuit = "login">
<cfset myFusebox.thisFuseaction = "isLoggedIn">
<cfset variables.securityService = myFusebox.getApplication().getApplicationData().servicefactory.getBean(beanName="securityService")/> 
<cfset attributes.isLoggedIn = variables.securityService.isLoggedIn(session) >
<cfif NOT attributes.isLoggedIn>
<cflocation url="#variables.mySelf#login.show" addtoken="false">
<cfabort>
</cfif>
<cfset myFusebox.thisCircuit = "app">
<cfset myFusebox.thisFuseaction = "getClients">
</cfif>
<cfset variables.clientArray = session.user.getTransferObject().getClientUserRelArray() >
<cfset variables.clientArLen = "#ArrayLen(variables.clientArray)#" />
<!--- do action="getProjects" --->
<cfset myFusebox.trace("Runtime","&lt;do action=""getProjects""/&gt;") >
<cfset myFusebox.thisFuseaction = "getProjects">
<cfif myfusebox.thisFuseaction neq 'initialize'>
<!--- do action="login.isLoggedIn" --->
<cfset myFusebox.trace("Runtime","&lt;do action=""login.isLoggedIn""/&gt;") >
<cfset myFusebox.thisCircuit = "login">
<cfset myFusebox.thisFuseaction = "isLoggedIn">
<cfset variables.securityService = myFusebox.getApplication().getApplicationData().servicefactory.getBean(beanName="securityService")/> 
<cfset attributes.isLoggedIn = variables.securityService.isLoggedIn(session) >
<cfif NOT attributes.isLoggedIn>
<cflocation url="#variables.mySelf#login.show" addtoken="false">
<cfabort>
</cfif>
<cfset myFusebox.thisCircuit = "app">
<cfset myFusebox.thisFuseaction = "getProjects">
</cfif>
<cfset attributes.xhr = "false" />
<cfset variables.projectManager = myFusebox.getApplication().getApplicationData().servicefactory.getBean(beanName="projectManager")/> 
<cfset variables.projects = variables.projectManager.getProjects(session.user.getTransferObject().getId(),attributes.client_id) >
<!--- do action="v.showLogForm" --->
<cfset myFusebox.trace("Runtime","&lt;do action=""v.showLogForm""/&gt;") >
<cfset myFusebox.thisCircuit = "v">
<cfset myFusebox.thisFuseaction = "showLogForm">
<cfif not isDefined("pageCss")><cfset pageCss = "column span-24 last" /></cfif>
<cfset myFusebox.trace("Runtime","&lt;include template=""dsp_showLogForm.cfm"" circuit=""v""/&gt;") >
<cftry>
<cfsavecontent variable="logEntry"><cfoutput><cfinclude template="../views/dsp_showLogForm.cfm"></cfoutput></cfsavecontent>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 19 and right(cfcatch.MissingFileName,19) is "dsp_showLogForm.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse dsp_showLogForm.cfm in circuit v which does not exist (from fuseaction v.showLogForm).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
<cfset xfa.processLogout = "login.logout" />
<cfset xfa.calendarView = "app.calendar" />
<cfset xfa.homeView = "app.main" />
<cfif StructKeyExists(variables,'body')>
<cfif not isDefined("pageCss")><cfset pageCss = "column span-24 last" /></cfif>
<cfset myFusebox.trace("Runtime","&lt;include template=""lay_template.cfm"" circuit=""v""/&gt;") >
<cftry>
<cfoutput><cfinclude template="../views/lay_template.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 16 and right(cfcatch.MissingFileName,16) is "lay_template.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse lay_template.cfm in circuit v which does not exist (from fuseaction v.$postfuseaction).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
</cfif>
<!--- do action="v.assemble" --->
<cfset myFusebox.trace("Runtime","&lt;do action=""v.assemble""/&gt;") >
<cfset myFusebox.thisFuseaction = "assemble">
<cfset myFusebox.trace("Runtime","&lt;include template=""dsp_main.cfm"" circuit=""v""/&gt;") >
<cftry>
<cfsavecontent variable="body"><cfoutput><cfinclude template="../views/dsp_main.cfm"></cfoutput></cfsavecontent>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 12 and right(cfcatch.MissingFileName,12) is "dsp_main.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse dsp_main.cfm in circuit v which does not exist (from fuseaction v.assemble).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
<cfset xfa.processLogout = "login.logout" />
<cfset xfa.calendarView = "app.calendar" />
<cfset xfa.homeView = "app.main" />
<cfif StructKeyExists(variables,'body')>
<cfif not isDefined("pageCss")><cfset pageCss = "column span-24 last" /></cfif>
<cfset myFusebox.trace("Runtime","&lt;include template=""lay_template.cfm"" circuit=""v""/&gt;") >
<cftry>
<cfoutput><cfinclude template="../views/lay_template.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 16 and right(cfcatch.MissingFileName,16) is "lay_template.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse lay_template.cfm in circuit v which does not exist (from fuseaction v.$postfuseaction).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
</cfif>
<cfset myFusebox.thisCircuit = "app">
<cfset myFusebox.thisFuseaction = "editLogEntry">
<cfelse>
<!--- do action="saveLogEntry" --->
<cfset myFusebox.trace("Runtime","&lt;do action=""saveLogEntry""/&gt;") >
<cfset myFusebox.thisFuseaction = "saveLogEntry">
<cfif myfusebox.thisFuseaction neq 'initialize'>
<!--- do action="login.isLoggedIn" --->
<cfset myFusebox.trace("Runtime","&lt;do action=""login.isLoggedIn""/&gt;") >
<cfset myFusebox.thisCircuit = "login">
<cfset myFusebox.thisFuseaction = "isLoggedIn">
<cfset variables.securityService = myFusebox.getApplication().getApplicationData().servicefactory.getBean(beanName="securityService")/> 
<cfset attributes.isLoggedIn = variables.securityService.isLoggedIn(session) >
<cfif NOT attributes.isLoggedIn>
<cflocation url="#variables.mySelf#login.show" addtoken="false">
<cfabort>
</cfif>
<cfset myFusebox.thisCircuit = "app">
<cfset myFusebox.thisFuseaction = "saveLogEntry">
</cfif>
<cfif not isDefined("variables.errors")><cfset variables.errors = "#ArrayNew(1)#" /></cfif>
<cfif not isDefined("attributes.log_id")><cfset attributes.log_id = "0" /></cfif>
<cfif not isDefined("attributes.fromDate")><cfset attributes.fromDate = "#CreateDate(mid(attributes.date,1,4),mid(attributes.date,6,2),mid(attributes.date,9,2))#" /></cfif>
<cfset variables.logger = myFusebox.getApplication().getApplicationData().servicefactory.getBean(beanName="logger")/> 
<cfif attributes.to_date eq ''>
<cfset attributes.toDate = "#attributes.fromDate#" />
<cfelse>
<cfset attributes.toDate = "#CreateDate(mid(attributes.to_date,1,4),mid(attributes.to_date,6,2),mid(attributes.to_date,9,2))#" />
</cfif>
<cfif DateCompare(attributes.toDate,attributes.fromDate) neq -1>
<cfset variables.logEntry = variables.logger.saveEntry(session.user.getTransferObject().getId(),attributes) >
<cfelse>
<cfset errorMsg = "Error the to date (#DateFormat(attributes.toDate,'yyyy/mm/dd')#) is before the from date (#DateFormat(attributes.fromDate,'yyyy/mm/dd')#)" />
<cfset tmpy = "#ArrayAppend(variables.errors,errorMsg)#" />
</cfif>
<cfset myFusebox.thisFuseaction = "editLogEntry">
<cflocation url="?fuseaction=app.main" addtoken="true">
<cfabort>
</cfif>
<cfcatch><cfrethrow></cfcatch>
</cftry>
<cfsetting enablecfoutputonly="false" />

