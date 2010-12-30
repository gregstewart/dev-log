<cfsilent>
    <cfif NOT StructKeyExists(variables,"numberOfEntries")>
        <cfset variables.numberOfEntries = ArrayLen(variables.logEntriesArray)/>
    </cfif>
</cfsilent>

<cfoutput>
    <cfif numberOfEntries>
	    <cfloop from="1" to="#variables.numberOfEntries#" index="i">
	        <h2>Log date: #DateFormat(variables.logEntriesArray[i].getLogDate(),"dddd dd mmmm yyyy")#</h2>
            <p>
            <cfif variables.logEntriesArray[i].hasClientDetails()>
                #variables.logEntriesArray[i].getClientDetails().getName()# - 
            </cfif>
            <cfif variables.logEntriesArray[i].hasProjectDetails()>
                #variables.logEntriesArray[i].getProjectDetails().getName()#
            </cfif>
            </p>
            #paragraphFormat(variables.logEntriesArray[i].getDescription())#
            <a href="#variables.mySelf##xfa.editLogEntry#&amp;log_id=#variables.logEntriesArray[i].getLog_Id()#&amp;client_id=#variables.logEntriesArray[i].getClientDetails().getId()#&amp;project_id=#variables.logEntriesArray[i].getProjectDetails().getId()#" title="Edit this entry">Edit</a>
            <hr />
	    </cfloop>
    <cfelse>
        <p>No log entries posted.</p>
    </cfif>
</cfoutput>