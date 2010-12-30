<cfsetting enablecfoutputonly="true" />
<cfprocessingdirective pageencoding="utf-8" />
<!--- circuit: signup --->
<!--- fuseaction: do --->
<cftry>
<cfset myFusebox.thisPhase = "appinit">
<cfset myFusebox.thisCircuit = "signup">
<cfset myFusebox.thisFuseaction = "do">
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
<cfset myFusebox.thisCircuit = "signup">
<cfset myFusebox.thisFuseaction = "do">
				<cfset myFusebox.getApplication().applicationStarted = true />
			</cfif>
		</cflock>
	</cfif>
</cfif>
<cfset myFusebox.thisPhase = "requestedFuseaction">
<cfif not isDefined("attributes.firstname")><cfset attributes.firstname = "" /></cfif>
<cfif not isDefined("attributes.lastname")><cfset attributes.lastname = "" /></cfif>
<cfif not isDefined("attributes.email")><cfset attributes.email = "" /></cfif>
<cfif not isDefined("attributes.username")><cfset attributes.username = "" /></cfif>
<cfif not isDefined("attributes.password")><cfset attributes.password = "" /></cfif>
<cfset variables.signupService = myFusebox.getApplication().getApplicationData().servicefactory.getBean(beanName="signupService")/> 
<cfset session.user = variables.signupService.do(attributes.firstname,attributes.lastname,attributes.email,attributes.username,attributes.password,session.user) >
<cfif ArrayLen(session.user.getErrors()) eq 0>
<cflocation url="#variables.mySelf#app.main" addtoken="false">
<cfabort>
<cfelse>
<cflocation url="#variables.mySelf#signup.show" addtoken="false">
<cfabort>
</cfif>
<cfcatch><cfrethrow></cfcatch>
</cftry>
<cfsetting enablecfoutputonly="false" />

