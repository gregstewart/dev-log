<cfcomponent displayname="Logger" hint="I log daily entries" output="false">
    <!--- Author: gregstewart - Date: 5/21/2007 --->
	<cffunction name="init" output="false" access="public" returntype="Logger" hint="I initialise the application">
	    <cfargument name="transfer" type="WEB-INF.cftags.component" required="true" />
        <cfargument name="loggerGateway" type="WEB-INF.cftags.component" required="true" />
        
        <cfset variables.transfer = arguments.transfer/>
        <cfset variables.loggerGateway = arguments.loggerGateway/>
        
        <cfreturn this/>
    </cffunction>
    
    <!--- Author: gregstewart - Date: 6/5/2007 --->
	<cffunction name="saveEntry" output="false" access="public" returntype="any" hint="I save a submitted entry">
        <cfargument name="userId" type="numeric" required="true" />
        <cfargument name="submittedValues" type="struct" required="true" />
        <!--- TODO: do I actually need a return value here?? --->
        <cfset var user = variables.transfer.get("user.User",arguments.userID)/>
        <cfset var client = variables.transfer.get("client.Client",arguments.submittedValues.client_Id) />
        <cfset var project = variables.transfer.get("project.Project",arguments.submittedValues.project_Id) />
        <cfset var entry = "" />
        <cfset var i = 0/>
        
        <cfloop from="#arguments.submittedValues.fromDate#" to="#arguments.submittedValues.toDate#" index="i">
            
	        <cfif arguments.submittedValues.log_Id neq 0>
	            <cfset entry = variables.transfer.get("log.Entry",arguments.submittedValues.log_Id)/>
	        <cfelse>
	            <cfset entry = variables.transfer.new("log.Entry")/>
	            <cfset entry.setDateAdded(now())/>
	        </cfif>
	        
	        <cfset entry.setClient(client)/>
	        <cfset entry.setProject(project)/>
	        <cfset entry.setUser(user)/>
	        
	        <cfset entry.setLogDate(CreateDate(Year(i), Month(i), Day(i)))/>
	        <cfset entry.setHours(arguments.submittedValues.hours)/>
	        <cfset entry.setDescription(arguments.submittedValues.details)/>
	        <cfset entry.setDateUpdated(now())/>
	        <cfset variables.transfer.save(entry)/>
            
        </cfloop>
        <!--- Very important!! This will force the log entries to be reloaded after the commit back to the database. 
        Previously in produciton mode this was resulting in no new entries appearing in the views --->
        <cfset variables.transfer.discard(user)/>
        
        <cfreturn entry/>
	</cffunction>
    
    <!--- Author: gregstewart - Date: 6/6/2007 --->
	<cffunction name="getEntry" output="false" access="public" returntype="WEB-INF.cftags.component" hint="I return transfer object representing a log entry">
	    <cfargument name="userId" type="numeric" required="true" />
        <cfargument name="logId" type="numeric" required="true" />
        <cfargument name="clientId" type="numeric" required="true" />
        <cfargument name="projectId" type="numeric" required="true" />
        
	    <cfset var user = variables.transfer.get("user.User",arguments.userID)/>
        <cfset var client = "" />
        <cfset var project = "" />
        <cfset var entry = "" />
        
        <cfif arguments.logId eq 0>
            <cfset entry = variables.transfer.new("log.Entry")/>
            <!--- Set some defaults --->
            <cfset entry.setLogDate(now())/>
            <cfset entry.setHours(0.0)/>
            
            <cfif arguments.clientId neq 0>
                <cfset client = variables.transfer.get("client.Client",arguments.clientId)/>
                <cfset entry.setClient(client)/>
            </cfif>
	        
            <cfif arguments.projectId neq 0>
                <cfset project = variables.transfer.get("project.Project",arguments.projectId)/>
                <cfset entry.setProject(project)/>
            </cfif>
            
            <cfreturn entry/>
	    <cfelse>
	        <cfreturn variables.transfer.get("log.Entry",arguments.logID)/>
	    </cfif>
	</cffunction>
    
    <!--- Author: gregstewart - Date: 6/13/2007 --->
	<cffunction name="getEntriesByUser" output="false" access="public" returntype="any" hint="Return all of the log entries for a given user id">
	    <cfargument name="userId" type="numeric" required="true"/>
        <!--- TODO: Nice to just return 10-20 entries maybe. Shame trnasfter doesn't support top --->
        <cfset var user = variables.transfer.get("user.User",arguments.userID)/>
        
        <cfreturn user.getLogUserRelArray()/>
    </cffunction>
    
    <!--- Author: gregstewart - Date: 6/13/2007 --->
	<cffunction name="getWeeklySummaryByUser" output="false" access="public" returntype="any" hint="I return a result set containing a summary of the hours spent by project for a given user">
	    <cfargument name="userId" type="numeric" required="true"/>
        <cfargument name="currentDate" type="date" required="false" default="#now()#" />
        
        <!--- // courtesy of: http://www.bennadel.com/blog/685-Getting-Week-Month-And-Year-Dates-Based-On-A-Given-Date-In-ColdFusion.htm --->
        <cfset var dtToday = arguments.currentDate />
        <!--- Get the week start date. --->
		<cfset var dtWeekStart = DateFormat((dtToday - DayOfWeek( dtToday ) + 1),"yyyy-mm-dd") />
		<!--- Get the week end date. --->
		<cfset var dtWeekEnd = DateFormat((dtToday + (7 - DayOfWeek( dtToday ))),"yyyy-mm-dd") />
        
        <cfreturn variables.loggerGateway.getSummaryByDate(arguments.userId,dtWeekStart,dtWeekEnd)/>
        
	</cffunction>
    
    <!--- Author: gregstewart - Date: 6/13/2007 --->
	<cffunction name="getMonthlySummaryByUser" output="false" access="public" returntype="any" hint="I return a result set containing a summary of the hours spent by project for a given user">
	    <cfargument name="userId" type="numeric" required="true"/>
        <cfargument name="currentDate" type="date" required="false" default="#now()#" />
        
        <!--- // courtesy of: http://www.bennadel.com/blog/685-Getting-Week-Month-And-Year-Dates-Based-On-A-Given-Date-In-ColdFusion.htm --->
        <cfset var dtToday = arguments.currentDate />
        <!--- Get the month start date. --->
		<cfset var dtMonthStart = DateFormat((dtToday - Day( dtToday ) + 1),"yyyy-mm-dd") />
		<!--- Get the month end date. --->
		<cfset var dtMonthEnd = DateFormat((dtToday + (DaysInMonth( dtToday ) - Day( dtToday ))),"yyyy-mm-dd") />
        
        <cfreturn variables.loggerGateway.getSummaryByDate(arguments.userId,dtMonthStart,dtMonthEnd)/>
        
	</cffunction>
    
    <!--- Author: gregstewart - Date: 6/28/2007 --->
	<cffunction name="getLogEntriesForCalendar" output="false" access="public" returntype="query" hint="I return the calendar data">
	    <cfargument name="userId" type="numeric" required="true"/>
        <cfargument name="currentDate" type="date" required="false" default="#now()#" />
        
        <cfset var dtMonthStart = DateFormat((arguments.currentDate - Day( arguments.currentDate ) + 1),'yyyy-mm-dd') />
	    <cfset var dtMonthEnd = DateFormat((arguments.currentDate + (DaysInMonth( arguments.currentDate ) - Day( arguments.currentDate ))),'yyyy-mm-dd') />`
        
        <cfreturn variables.loggerGateway.getCalendarData(arguments.userId,dtMonthStart,dtMonthEnd)/>
    </cffunction>
</cfcomponent>