<div class="column span-18">
	<cfif StructKeyExists(variables,"logEntry")><cfoutput>#logEntry#</cfoutput></cfif>
	<cfif StructKeyExists(variables,"entryList")><cfoutput>#entryList#</cfoutput></cfif>
</div>
<div class="column span-6 last">
    <cfif StructKeyExists(variables,"summary")><cfoutput>#summary#</cfoutput></cfif>
</div>