<cfsetting enablecfoutputonly="true" />
<cfprocessingdirective pageencoding="utf-8" />
<!--- circuit: login --->
<!--- fuseaction: show --->
<cftry>
<cfset myFusebox.thisPhase = "appinit">
<cfset myFusebox.thisCircuit = "login">
<cfset myFusebox.thisFuseaction = "show">
<cfif myFusebox.applicationStart>
	<cfif not myFusebox.getApplication().applicationStarted>
		<cflock name="#application.ApplicationName#_fusebox_#FUSEBOX_APPLICATION_KEY#_appinit" type="exclusive" timeout="30">
			<cfif not myFusebox.getApplication().applicationStarted>
<!--- fuseaction action="app.initialize" --->
<cfset myFusebox.thisCircuit = "app">
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
<cfset myFusebox.thisCircuit = "login">
<cfset myFusebox.thisFuseaction = "show">
				<cfset myFusebox.getApplication().applicationStarted = true />
			</cfif>
		</cflock>
	</cfif>
</cfif>
<!--- do action="v.showLogin" --->
<cfset myFusebox.thisPhase = "requestedFuseaction">
<cfset myFusebox.thisCircuit = "v">
<cfset myFusebox.thisFuseaction = "showLogin">
<cfset xfa.processLogin = "login.do" />
<cfset xfa.forgottenPassword = "signup.passwordReminder" />
<cfset xfa.signUp = "signup.show" />
<cfset pageCss = "column prepend-4 span-16 append-4 last" />
<cftry>
<cfsavecontent variable="body"><cfoutput><cfinclude template="../views/dsp_showLogin.cfm"></cfoutput></cfsavecontent>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 17 and right(cfcatch.MissingFileName,17) is "dsp_showLogin.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse dsp_showLogin.cfm in circuit v which does not exist (from fuseaction v.showLogin).">
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
<!--- do action="clearErrors" --->
<cfset myFusebox.thisCircuit = "login">
<cfset myFusebox.thisFuseaction = "clearErrors">
<cfset variables.securityService = myFusebox.getApplication().getApplicationData().servicefactory.getBean(beanName="securityService")/> 
<cfset session.user = variables.securityService.clearErrors(session.user) >
<cfcatch><cfrethrow></cfcatch>
</cftry>
<cfsetting enablecfoutputonly="false" />

