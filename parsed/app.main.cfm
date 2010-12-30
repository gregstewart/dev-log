<cfsetting enablecfoutputonly="true" />
<cfprocessingdirective pageencoding="utf-8" />
<!--- circuit: app --->
<!--- fuseaction: main --->
<cftry>
<cfset myFusebox.thisPhase = "appinit">
<cfset myFusebox.thisCircuit = "app">
<cfset myFusebox.thisFuseaction = "main">
<cfif myFusebox.applicationStart>
	<cfif not myFusebox.getApplication().applicationStarted>
		<cflock name="#application.ApplicationName#_fusebox_#FUSEBOX_APPLICATION_KEY#_appinit" type="exclusive" timeout="30">
			<cfif not myFusebox.getApplication().applicationStarted>
<!--- fuseaction action="app.initialize" --->
<cfset myFusebox.thisFuseaction = "initialize">
<cfif myfusebox.thisFuseaction neq 'initialize'>
<!--- do action="login.isLoggedIn" --->
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
<cfset myFusebox.thisFuseaction = "main">
				<cfset myFusebox.getApplication().applicationStarted = true />
			</cfif>
		</cflock>
	</cfif>
</cfif>
<cfset myFusebox.thisPhase = "requestedFuseaction">
<cfif myfusebox.thisFuseaction neq 'initialize'>
<!--- do action="login.isLoggedIn" --->
<cfset myFusebox.thisCircuit = "login">
<cfset myFusebox.thisFuseaction = "isLoggedIn">
<cfset variables.securityService = myFusebox.getApplication().getApplicationData().servicefactory.getBean(beanName="securityService")/> 
<cfset attributes.isLoggedIn = variables.securityService.isLoggedIn(session) >
<cfif NOT attributes.isLoggedIn>
<cflocation url="#variables.mySelf#login.show" addtoken="false">
<cfabort>
</cfif>
<cfset myFusebox.thisCircuit = "app">
<cfset myFusebox.thisFuseaction = "main">
</cfif>
<!--- do action="javaScriptDisabled" --->
<cfset myFusebox.thisFuseaction = "javaScriptDisabled">
<cfif myfusebox.thisFuseaction neq 'initialize'>
<!--- do action="login.isLoggedIn" --->
<cfset myFusebox.thisCircuit = "login">
<cfset myFusebox.thisFuseaction = "isLoggedIn">
<cfset variables.securityService = myFusebox.getApplication().getApplicationData().servicefactory.getBean(beanName="securityService")/> 
<cfset attributes.isLoggedIn = variables.securityService.isLoggedIn(session) >
<cfif NOT attributes.isLoggedIn>
<cflocation url="#variables.mySelf#login.show" addtoken="false">
<cfabort>
</cfif>
<cfset myFusebox.thisCircuit = "app">
<cfset myFusebox.thisFuseaction = "javaScriptDisabled">
</cfif>
<cfif StructKeyExists(attributes,'load_projects')>
<!--- do action="getProjects" --->
<cfset myFusebox.thisFuseaction = "getProjects">
<cfif myfusebox.thisFuseaction neq 'initialize'>
<!--- do action="login.isLoggedIn" --->
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
<cfset myFusebox.thisFuseaction = "javaScriptDisabled">
</cfif>
<cfif StructKeyExists(attributes,'add_project')>
<cflocation url="?fuseaction=app.addProject&client_id=#attributes.client_id#" addtoken="true">
<cfabort>
</cfif>
<cfif StructKeyExists(attributes,'add_client')>
<cflocation url="?fuseaction=app.addClient" addtoken="true">
<cfabort>
</cfif>
<cfif StructKeyExists(attributes,'submit')>
<!--- do action="saveLogEntry" --->
<cfset myFusebox.thisFuseaction = "saveLogEntry">
<cfif myfusebox.thisFuseaction neq 'initialize'>
<!--- do action="login.isLoggedIn" --->
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
<cfset myFusebox.thisFuseaction = "javaScriptDisabled">
</cfif>
<!--- do action="listLogEntries" --->
<cfset myFusebox.thisFuseaction = "listLogEntries">
<cfif myfusebox.thisFuseaction neq 'initialize'>
<!--- do action="login.isLoggedIn" --->
<cfset myFusebox.thisCircuit = "login">
<cfset myFusebox.thisFuseaction = "isLoggedIn">
<cfset variables.securityService = myFusebox.getApplication().getApplicationData().servicefactory.getBean(beanName="securityService")/> 
<cfset attributes.isLoggedIn = variables.securityService.isLoggedIn(session) >
<cfif NOT attributes.isLoggedIn>
<cflocation url="#variables.mySelf#login.show" addtoken="false">
<cfabort>
</cfif>
<cfset myFusebox.thisCircuit = "app">
<cfset myFusebox.thisFuseaction = "listLogEntries">
</cfif>
<cfif not isDefined("variables.numberOfEntries")><cfset variables.numberOfEntries = "20" /></cfif>
<!--- do action="getUserLogEntries" --->
<cfset myFusebox.thisFuseaction = "getUserLogEntries">
<cfif myfusebox.thisFuseaction neq 'initialize'>
<!--- do action="login.isLoggedIn" --->
<cfset myFusebox.thisCircuit = "login">
<cfset myFusebox.thisFuseaction = "isLoggedIn">
<cfset variables.securityService = myFusebox.getApplication().getApplicationData().servicefactory.getBean(beanName="securityService")/> 
<cfset attributes.isLoggedIn = variables.securityService.isLoggedIn(session) >
<cfif NOT attributes.isLoggedIn>
<cflocation url="#variables.mySelf#login.show" addtoken="false">
<cfabort>
</cfif>
<cfset myFusebox.thisCircuit = "app">
<cfset myFusebox.thisFuseaction = "getUserLogEntries">
</cfif>
<cfset variables.logger = myFusebox.getApplication().getApplicationData().servicefactory.getBean(beanName="logger")/> 
<cfset variables.logEntriesArray = variables.logger.getEntriesByUser(session.user.getTransferObject().getId()) >
<!--- do action="v.listLogEntries" --->
<cfset myFusebox.thisCircuit = "v">
<cfset myFusebox.thisFuseaction = "listLogEntries">
<cfset xfa.editLogEntry = "app.editLogEntry" />
<cftry>
<cfsavecontent variable="entryList"><cfoutput><cfinclude template="../views/dsp_listLogEntries.cfm"></cfoutput></cfsavecontent>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 22 and right(cfcatch.MissingFileName,22) is "dsp_listLogEntries.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse dsp_listLogEntries.cfm in circuit v which does not exist (from fuseaction v.listLogEntries).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
<cfset xfa.processLogout = "login.logout" />
<cfset xfa.calendarView = "app.calendar" />
<cfset xfa.homeView = "app.main" />
<cfif StructKeyExists(variables,'body')>
<cfif not isDefined("pageCss")><cfset pageCss = "column span-24 last" /></cfif>
<cftry>
<cfoutput><cfinclude template="../views/lay_template.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 16 and right(cfcatch.MissingFileName,16) is "lay_template.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse lay_template.cfm in circuit v which does not exist (from fuseaction v.$postfuseaction).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
</cfif>
<!--- do action="getWeeklySummary" --->
<cfset myFusebox.thisCircuit = "app">
<cfset myFusebox.thisFuseaction = "getWeeklySummary">
<cfif myfusebox.thisFuseaction neq 'initialize'>
<!--- do action="login.isLoggedIn" --->
<cfset myFusebox.thisCircuit = "login">
<cfset myFusebox.thisFuseaction = "isLoggedIn">
<cfset variables.securityService = myFusebox.getApplication().getApplicationData().servicefactory.getBean(beanName="securityService")/> 
<cfset attributes.isLoggedIn = variables.securityService.isLoggedIn(session) >
<cfif NOT attributes.isLoggedIn>
<cflocation url="#variables.mySelf#login.show" addtoken="false">
<cfabort>
</cfif>
<cfset myFusebox.thisCircuit = "app">
<cfset myFusebox.thisFuseaction = "getWeeklySummary">
</cfif>
<cfset variables.logger = myFusebox.getApplication().getApplicationData().servicefactory.getBean(beanName="logger")/> 
<cfset variables.summary = variables.logger.getWeeklySummaryByUser(session.user.getTransferObject().getId()) >
<!--- do action="v.showSummary" --->
<cfset myFusebox.thisCircuit = "v">
<cfset myFusebox.thisFuseaction = "showSummary">
<cftry>
<cfsavecontent variable="summary"><cfoutput><cfinclude template="../views/dsp_summary.cfm"></cfoutput></cfsavecontent>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 15 and right(cfcatch.MissingFileName,15) is "dsp_summary.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse dsp_summary.cfm in circuit v which does not exist (from fuseaction v.showSummary).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
<cfset xfa.processLogout = "login.logout" />
<cfset xfa.calendarView = "app.calendar" />
<cfset xfa.homeView = "app.main" />
<cfif StructKeyExists(variables,'body')>
<cfif not isDefined("pageCss")><cfset pageCss = "column span-24 last" /></cfif>
<cftry>
<cfoutput><cfinclude template="../views/lay_template.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 16 and right(cfcatch.MissingFileName,16) is "lay_template.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse lay_template.cfm in circuit v which does not exist (from fuseaction v.$postfuseaction).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
</cfif>
<!--- do action="logEntry" --->
<cfset myFusebox.thisCircuit = "app">
<cfset myFusebox.thisFuseaction = "logEntry">
<cfif myfusebox.thisFuseaction neq 'initialize'>
<!--- do action="login.isLoggedIn" --->
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
<cfset myFusebox.thisFuseaction = "getClients">
<cfif myfusebox.thisFuseaction neq 'initialize'>
<!--- do action="login.isLoggedIn" --->
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
<cfset myFusebox.thisFuseaction = "getProjects">
<cfif myfusebox.thisFuseaction neq 'initialize'>
<!--- do action="login.isLoggedIn" --->
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
<cfset myFusebox.thisCircuit = "v">
<cfset myFusebox.thisFuseaction = "showLogForm">
<cfif not isDefined("pageCss")><cfset pageCss = "column span-24 last" /></cfif>
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
<cftry>
<cfoutput><cfinclude template="../views/lay_template.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 16 and right(cfcatch.MissingFileName,16) is "lay_template.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse lay_template.cfm in circuit v which does not exist (from fuseaction v.$postfuseaction).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
</cfif>
<!--- do action="v.assemble" --->
<cfset myFusebox.thisFuseaction = "assemble">
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
<cftry>
<cfoutput><cfinclude template="../views/lay_template.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 16 and right(cfcatch.MissingFileName,16) is "lay_template.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse lay_template.cfm in circuit v which does not exist (from fuseaction v.$postfuseaction).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
</cfif>
<cfcatch><cfrethrow></cfcatch>
</cftry>
<cfsetting enablecfoutputonly="false" />

