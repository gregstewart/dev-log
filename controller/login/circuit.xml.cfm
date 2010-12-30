<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!--
	Example circuit.xml file for the controller portion of an application.
	Only the controller circuit has public access - the controller circuit
	contains all of the fuseactions that are used in links and form posts
	within your application.
-->
<circuit access="public" xmlns:cs="cs/">    
    <!--
		Checks the session scope for an authenticated user. On success continue, on failure re-direct to login page:
	-->
	<fuseaction name="isLoggedIn">
        <cs:get bean="securityService" returnvariable="variables.securityService" coldspringfactory="servicefactory" />
		<invoke object="variables.securityService" methodcall="isLoggedIn(session)" returnvariable="attributes.isLoggedIn" />
        
        <if condition="NOT attributes.isLoggedIn">
            <true>
                <relocate url="#variables.mySelf#login.show" type="client" />
            </true>
        </if>
	</fuseaction>
	
    <fuseaction name="do">
        <cs:get bean="securityService" returnvariable="variables.securityService" coldspringfactory="servicefactory" />
		<invoke object="variables.securityService" methodcall="authenticate(attributes.username,attributes.password,session.user)" returnvariable="session.user" />
        
        <if condition="session.user.getIsLoggedIn()">
            <true>
                <relocate url="#variables.mySelf#app.main" type="client" />
            </true>
            <false>
                <relocate url="#variables.mySelf#login.show" type="client" />
            </false>
        </if>
    </fuseaction>
    
    <fuseaction name="logout">
        <cs:get bean="securityService" returnvariable="variables.securityService" coldspringfactory="servicefactory" />
		<invoke object="variables.securityService" methodcall="logout(session.user)" returnvariable="session.user" />
        
        <if condition="session.user.getIsLoggedIn()">
            <true>
                <relocate url="#variables.mySelf#app.main" type="client" />
            </true>
            <false>
                <relocate url="#variables.mySelf#login.show" type="client" />
            </false>
        </if>
    </fuseaction>
    
    <fuseaction name="clearErrors">
        <cs:get bean="securityService" returnvariable="variables.securityService" coldspringfactory="servicefactory" />
		<invoke object="variables.securityService" methodcall="clearErrors(session.user)" returnvariable="session.user" />
    </fuseaction>
    
	<fuseaction name="show">
        <do action="v.showLogin"/>
        <do action="clearErrors"/>
    </fuseaction>
</circuit>

