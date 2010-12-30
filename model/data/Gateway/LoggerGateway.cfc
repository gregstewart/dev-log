<cfcomponent displayname="Logger Gateway" hint="I handle gateway operations on the log entry table" output="false">
    <!--- Author: gregstewart - Date: 6/20/2007 --->
	<cffunction name="init" output="false" access="public" returntype="LoggerGateway" hint="I initialise the component">
	    <cfargument name="datasource" type="WEB-INF.cftags.component" required="true" />
        
        <cfset variables.dsn = arguments.datasource.getName()/>
        
        <cfreturn this/>
	</cffunction>
    
    <!--- Author: gregstewart - Date: 6/20/2007 --->
	<cffunction name="getSummaryByDate" output="false" access="public" returntype="query" hint="I return the summary for a given user for a start and end date">
	    <cfargument name="userId" type="numeric" required="true" />
	    <cfargument name="dateStart" type="Date" required="true" />
        <cfargument name="dateEnd" type="Date" required="true" />
        
        <cfset var weeklySummary = QueryNew("dummy")/>
	    
        <cfquery name="weeklySummary" datasource="#variables.dsn#">
	        SELECT sum(l.hours) as total_hours, p.title 
			FROM iTrack.logEntry l 
				INNER JOIN iTrack.project p ON p.id = l.project_id
			WHERE l.user_id = #arguments.userId# 
			AND l.date BETWEEN '#arguments.dateStart#' AND '#arguments.dateEnd#'
	        GROUP BY l.project_id
	    </cfquery>
	    
	    <cfreturn weeklySummary/>
	</cffunction>
    
    <!--- Author: gregstewart - Date: 6/28/2007 --->
	<cffunction name="getCalendarData" output="false" access="public" returntype="query" hint="I return log entries for the calendar view">
	    <cfargument name="userId" type="numeric" required="true" />
	    <cfargument name="dateStart" type="Date" required="true" />
	    <cfargument name="dateEnd" type="Date" required="true" />
	    
	    <cfset var calendarData = QueryNew("dummy")/>
	    <cfquery name="calendarData" datasource="#variables.dsn#">
	        SELECT SUM(l.hours) AS total_hours, l.date as log_date, cl.name 
	        FROM logEntry l
				INNER JOIN client cl ON cl.id = l.client_id
	        WHERE l.user_id = #arguments.userId# 
				AND l.date BETWEEN '#arguments.dateStart#' AND '#arguments.dateEnd#'
			GROUP BY date, client_id
			ORDER BY date
	    </cfquery>

        <cfreturn calendarData/>
	</cffunction>
</cfcomponent>