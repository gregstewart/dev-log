<cfsavecontent variable="header">
<style>
    table {
        border: 1px solid #fff;
    }
    tr {
    }
    td {
        border: 1px solid #000;
    }
    .even {
        background-color: #eee;
    }
    .today {
        background-color: #f00;
    }
</style>
</cfsavecontent>
<cfhtmlhead text="#variables.header#">
<cfoutput>
<a href="#variables.myself##xfa.calendar#&date=#DateAdd("m",-1,attributes.date)#">Previous</a> | <a href="#variables.myself##xfa.calendar#&date=#DateAdd("m",1,attributes.date)#">Next</a>
<h2>#DateFormat(attributes.date,"mmmm")#</h2>

<table border="1" width="100%" height="100%">
   <tr>
   <cfloop index="x" from="1" to="7">
      <th>#dayOfWeekAsString(x)#</th>
   </cfloop>
   </tr>

<cfset firstOfTheMonth = createDate(year(attributes.date), month(attributes.date), 1)>
<cfset dow = dayofWeek(firstOfTheMonth)>
<cfset pad = dow - 1>

<tr>

<cfif pad gt 0>
   <td colspan="#pad#">&nbsp;</td>
</cfif>

<cfset days = daysInMonth(attributes.date)>
<cfset counter = pad + 1>
<cfloop index="x" from="1" to="#days#">
   <cfif x mod 2>
       <cfset class=" even"> 
   </cfif>
   <cfif x is day(attributes.date) AND month(attributes.date) eq month(now())>
      <td class="today#class#">
   <cfelse>
      <td class="#class#">
   </cfif>
   
   #x#
   <cfquery name="tmpyQry" dbtype="query">
       SELECT total_hours, name
       FROM variables.calendarData
       WHERE log_date = '#year(attributes.date)#-#month(attributes.date)#-#x#'
   </cfquery>
   
   <cfif tmpyQry.recordcount>
       <cfloop query="tmpyQry">
   <div>#name# - #total_hours#</div> 
       </cfloop>
   </cfif>
   </td>
   <cfset counter = counter + 1>
   <cfif counter is 8>
      </tr>
      <cfif x lt days>
         <cfset counter = 1>
         <tr>
      </cfif>
   </cfif>
   <cfset class=""> 
</cfloop>

<cfif counter is not 8>
   <cfset endPad = 8 - counter>
   <td colspan="#endPad#">&nbsp;</td>
</cfif>
</table>