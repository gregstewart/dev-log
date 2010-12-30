<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!--
	Example circuit.xml file for the views portion of an application.
-->
<circuit access="internal">
	
	<!--
		Apply a standard layout to the result of all display fuseactions.
		This is fine for simple applications that have just one layout but
		for more complicated situations you will either need to move to
		multiple view circuits or a view circuit and a layout circuit and
		may have to explicitly call a layout fuseaction from your other
		display fuseactions.
	-->
	<postfuseaction>
		<xfa name="processLogout" value="login.logout" />
        <xfa name="calendarView" value="app.calendar" />
        <xfa name="homeView" value="app.main" />
        
	    <if condition="StructKeyExists(variables,'body')">
            <true>
                <set name="pageCss" value="column span-24 last" overwrite="false" />
                <include template="lay_template" />
            </true>
        </if>
	</postfuseaction>
	
	<!--
		Example display fuseaction. The output of the template is placed
		in a content variable which is used in the layout template.
	-->
	<fuseaction name="sayHello">
		<include template="dsp_hello" contentvariable="body" />
	</fuseaction>
	
    <fuseaction name="showLogin">
        <xfa name="processLogin" value="login.do" />
        <xfa name="forgottenPassword" value="signup.passwordReminder" />
        <xfa name="signUp" value="signup.show" />
        <set name="pageCss" value="column prepend-4 span-16 append-4 last" />
		<include template="dsp_showLogin" contentvariable="body" />
    </fuseaction>
    
    <fuseaction name="showLogForm">
        <set name="pageCss" value="column span-24 last" overwrite="false" />
        <include template="dsp_showLogForm" contentvariable="logEntry" />
	</fuseaction>
    
    <fuseaction name="listLogEntries">
        <xfa name="editLogEntry" value="app.editLogEntry" />
        <include template="dsp_listLogEntries" contentvariable="entryList" />
	</fuseaction>
    
    <fuseaction name="showSummary">
        <include template="dsp_summary" contentvariable="summary"/>
    </fuseaction>
    
    <fuseaction name="showReport">
        <include template="dsp_report" contentvariable="body"/>
    </fuseaction>
    
    <fuseaction name="showCalendar">
        <xfa name="calendar" value="app.calendar" />
        
        <include template="dsp_calendar" contentvariable="body"/>
    </fuseaction>
    
    <fuseaction name="assemble">
        <include template="dsp_main" contentvariable="body" />
    </fuseaction>
    
    <fuseaction name="addClient">
        <xfa name="addClient" value="app.addClient" />
        <xfa name="backToLog" value="app.main"/>
        <include template="dsp_addClientForm" contentvariable="body" />
    </fuseaction>    
    
    <fuseaction name="addProject">
        <xfa name="addProject" value="app.addProject" />
        <xfa name="backToLog" value="app.main"/>
        <include template="dsp_addProjectForm" contentvariable="body" />
    </fuseaction>
    
    <fuseaction name="showSignUp">
        <xfa name="doSignup" value="signup.do" />
        <xfa name="back" value="app.main"/>
        <include template="dsp_showSignUp" contentvariable="body" />
    </fuseaction>
</circuit>