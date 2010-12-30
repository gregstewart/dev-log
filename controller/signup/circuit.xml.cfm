<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!--
	Example circuit.xml file for the controller portion of an application.
	Only the controller circuit has public access - the controller circuit
	contains all of the fuseactions that are used in links and form posts
	within your application.
-->
<circuit access="public" xmlns:cs="cs/">    
    
	<fuseaction name="show">
        <do action="v.showSignup"/>
    </fuseaction>
    
    <fuseaction name="do">
        <set name="attributes.firstname" value="" overwrite="false"/>
        <set name="attributes.lastname" value="" overwrite="false"/>
        <set name="attributes.email" value="" overwrite="false"/>
        <set name="attributes.username" value="" overwrite="false"/>
        <set name="attributes.password" value="" overwrite="false"/>
        
        <cs:get bean="signupService" returnvariable="variables.signupService" coldspringfactory="servicefactory" />
		<invoke object="variables.signupService" methodcall="do(attributes.firstname,attributes.lastname,attributes.email,attributes.username,attributes.password,session.user)" returnvariable="session.user" />
        
        <if condition="ArrayLen(session.user.getErrors()) eq 0">
            <true>
                <relocate url="#variables.mySelf#app.main" type="client" />
            </true>
            <false>
                <relocate url="#variables.mySelf#signup.show" type="client" />
            </false>
        </if>
        
    </fuseaction>
    
    <fuseaction name="passwordReminder">
        <do action="v.showPasswordReminder"/>
    </fuseaction>
</circuit>

