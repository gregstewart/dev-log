<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!--
	Example circuit.xml file for the controller portion of an application.
	Only the controller circuit has public access - the controller circuit
	contains all of the fuseactions that are used in links and form posts
	within your application.
-->
<circuit access="public" xmlns:cs="cs/">
	<prefuseaction>
        <if condition="myfusebox.thisFuseaction neq 'initialize'">
	        <true>
	            <do action="login.isLoggedIn"/>
	        </true>
        </if>
    </prefuseaction>
    
    <!--
		CS initiliatisation
	-->
    <fuseaction name="initialize">
	   <cs:initialize coldspringfactory="servicefactory" beanDefinitionFile="#expandPath('config/cs.xml')#"/>
	</fuseaction>
    
	<!--
		Default fuseaction for application, uses model and view circuits
		to do all of its work:
	-->
	<fuseaction name="main">
        <do action="javaScriptDisabled"/>
        <do action="listLogEntries"/>
        <do action="getWeeklySummary"/>
        <do action="logEntry"/>
        
        <do action="v.assemble"/>
	</fuseaction>
    
    <fuseaction name="logEntry">
        <set name="attributes.log_id" value="0" overwrite="false"/>
        <set name="attributes.client_id" value="0" overwrite="false"/>
        <set name="attributes.project_id" value="0" overwrite="false"/>
        
        <cs:get bean="logger" returnvariable="variables.logger" coldspringfactory="servicefactory" />
        <invoke object="variables.logger" methodcall="getEntry(session.user.getTransferObject().getId(),attributes.log_id,attributes.client_id,attributes.project_id)" returnvariable="variables.logEntry" />
        
        <do action="getClients"/>
        <do action="getProjects"/>
        
        <do action="v.showLogForm"/>
    </fuseaction>
    
    <fuseaction name="editLogEntry">
        
        <if condition="NOT StructKeyExists(attributes,'submit')">
            <true>
                <do action="logEntry"/>
                <do action="v.assemble"/>
            </true>
            <false>
                <do action="saveLogEntry"/>
                <relocate url="?fuseaction=app.main" addtoken="true" type="client"/>
            </false>
        </if>
        
    </fuseaction>
    
    <fuseaction name="saveLogEntry">
        <set name="variables.errors" value="#ArrayNew(1)#" overwrite="false"/>
        <set name="attributes.log_id" value="0" overwrite="false"/>
        <set name="attributes.fromDate" value="#CreateDate(mid(attributes.date,1,4),mid(attributes.date,6,2),mid(attributes.date,9,2))#" overwrite="false"/>
        
        <cs:get bean="logger" returnvariable="variables.logger" coldspringfactory="servicefactory" />
        
        <!-- set the toDate -->
        <if condition="attributes.to_date eq ''">
            <true>
                <set name="attributes.toDate" value="#attributes.fromDate#"/>
            </true>
            <false>
                <set name="attributes.toDate" value="#CreateDate(mid(attributes.to_date,1,4),mid(attributes.to_date,6,2),mid(attributes.to_date,9,2))#"/>
            </false>
        </if>
        
        <!-- validate dates -->
        <if condition="DateCompare(attributes.toDate,attributes.fromDate) neq -1">
            <true>
                <invoke object="variables.logger" methodcall="saveEntry(session.user.getTransferObject().getId(),attributes)" returnvariable="variables.logEntry" />
            </true>
            <false>
                <set name="errorMsg" value="Error the to date (#DateFormat(attributes.toDate,'yyyy/mm/dd')#) is before the from date (#DateFormat(attributes.fromDate,'yyyy/mm/dd')#)"/>
                <set name="tmpy" value="#ArrayAppend(variables.errors,errorMsg)#"/>
            </false>
        </if>
    </fuseaction>
	
    <fuseaction name="getProjects">
        <set name="attributes.xhr" value="false"/>
        
        <cs:get bean="projectManager" returnvariable="variables.projectManager" coldspringfactory="servicefactory" />
		<invoke object="variables.projectManager" methodcall="getProjects(session.user.getTransferObject().getId(),attributes.client_id)" returnvariable="variables.projects" />
        
    </fuseaction>
    
    <fuseaction name="addProject">
        <set name="attributes.client_id" value="" overwrite="false"/>
        <set name="attributes.project_id" value="0" overwrite="false"/>
        
        <cs:get bean="projectManager" returnvariable="variables.projectManager" coldspringfactory="servicefactory" />
		        
        
        <if condition="StructKeyExists(attributes,'add_project')">
            <true>
                <invoke object="variables.projectManager" methodcall="set(session.user.getTransferObject().getId(),attributes)" returnvariable="variables.project" />
            </true>
            <false>
                <invoke object="variables.projectManager" methodcall="get(attributes.project_id)" returnvariable="variables.project" />
            </false>
        </if>
                
        <do action="getClients"/>
        <do action="v.addProject"/>
        
    </fuseaction>
    
    <fuseaction name="addClient">
        <set name="attributes.client_id" value="0" overwrite="false"/>
        <set name="attributes.client_name" value="" overwrite="false"/>
        
        <cs:get bean="clientManager" returnvariable="variables.clientManager" coldspringfactory="servicefactory" />
		        
        
        <if condition="StructKeyExists(attributes,'add_client')">
            <true>
                <invoke object="variables.clientManager" methodcall="set(session.user.getTransferObject().getId(),attributes)" returnvariable="variables.client" />
            </true>
            <false>
                <invoke object="variables.clientManager" methodcall="get(attributes.client_id)" returnvariable="variables.client" />
            </false>
        </if>
                
        <do action="v.addClient"/>
        
    </fuseaction>
    
    <fuseaction name="javaScriptDisabled">
        <if condition="StructKeyExists(attributes,'load_projects')">
            <true>
                <do action="getProjects"/>
            </true>
        </if>
        
        <if condition="StructKeyExists(attributes,'add_project')">
            <true>
                <relocate url="?fuseaction=app.addProject&amp;client_id=#attributes.client_id#" addtoken="true" type="client"/>
            </true>
        </if>
        
        <if condition="StructKeyExists(attributes,'add_client')">
            <true>
                <relocate url="?fuseaction=app.addClient" addtoken="true" type="client"/>
            </true>
        </if>
        
        <if condition="StructKeyExists(attributes,'submit')">
            <true>
                <do action="saveLogEntry"/>
            </true>
        </if>
    </fuseaction>
    
    <fuseaction name="getClients">
        <invoke object="session.user" methodcall="getTransferObject().getClientUserRelArray()" returnvariable="variables.clientArray" />
        <set name="variables.clientArLen" value="#ArrayLen(variables.clientArray)#"/>
    </fuseaction>
    
    <fuseaction name="getUserLogEntries">
        <cs:get bean="logger" returnvariable="variables.logger" coldspringfactory="servicefactory" />
		<invoke object="variables.logger" methodcall="getEntriesByUser(session.user.getTransferObject().getId())" returnvariable="variables.logEntriesArray" />
    </fuseaction>
    
    <fuseaction name="getWeeklySummary">
        <cs:get bean="logger" returnvariable="variables.logger" coldspringfactory="servicefactory" />
		<invoke object="variables.logger" methodcall="getWeeklySummaryByUser(session.user.getTransferObject().getId())" returnvariable="variables.summary" />
        <do action="v.showSummary"/>
    </fuseaction>
    
    <fuseaction name="getMonthlySummary">
        <set name="attributes.date" value="#now()#" overwrite="false"/>
        <cs:get bean="logger" returnvariable="variables.logger" coldspringfactory="servicefactory" />
		<invoke object="variables.logger" methodcall="getMonthlySummaryByUser(session.user.getTransferObject().getId(),attributes.date)" returnvariable="variables.summary" />
        <do action="v.showReport"/>
    </fuseaction>
    
    <fuseaction name="listLogEntriesForCalendar">
        <cs:get bean="logger" returnvariable="variables.logger" coldspringfactory="servicefactory" />
		<invoke object="variables.logger" methodcall="getLogEntriesForCalendar(session.user.getTransferObject().getId(),attributes.date)" returnvariable="variables.calendarData" />
    </fuseaction>
    
    <fuseaction name="listLogEntries">
        <set name="variables.numberOfEntries" value="20" overwrite="false"/>
        
        <do action="getUserLogEntries"/>
        <do action="v.listLogEntries"/>
    </fuseaction>
    
    <fuseaction name="calendar">
        <set name="attributes.date" value="#now()#" overwrite="false"/>
        <do action="listLogEntriesForCalendar"/>
        <do action="v.showCalendar"/>
    </fuseaction>
    
    <fuseaction name="feed">
    
    </fuseaction>
</circuit>
