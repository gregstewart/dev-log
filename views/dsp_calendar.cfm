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
    .date {
        border: 1px solid #000;
        text-align: center;
    }
    .header {
        background-color: #fff;
        height: 30px;
    }
    .cell {
        height: 100px;
    }
</style>
</cfsavecontent>
<cfhtmlhead text="#variables.header#">
<cfoutput>
<div class="column span-24">
<a href="#variables.myself##xfa.calendar#&date=#DateAdd("m",-1,attributes.date)#">Previous</a> | <a href="#variables.myself##xfa.calendar#&date=#DateAdd("m",1,attributes.date)#">Next</a>
<h2>#DateFormat(attributes.date,"mmmm")#</h2>
</div>

<cfloop index="x" from="1" to="7">

    <cfif x eq 1 OR x eq 7>
        <cfset spanner = 2>
    <cfelse>
        <cfset spanner = 4>
    </cfif>

<div class="column span-#spanner#<cfif x eq 7> last</cfif> header">
    #dayOfWeekAsString(x)#
</div>
</cfloop>

<cfset firstOfTheMonth = createDate(year(attributes.date), month(attributes.date), 1)>
<cfset dow = dayofWeek(firstOfTheMonth)>
<cfset pad = dow - 1>

<cfif pad gt 0>
    <cfset prePad = (pad * 4)-2>
<div class="column span-#prePad#">
    &nbsp;
</div>
</cfif>

<cfset days = daysInMonth(attributes.date)>
<cfset counter = pad + 1>

<cfloop index="x" from="1" to="#days#">
   <cfset spanner = 4/>
   
   <cfif x mod 2>
       <cfset class = " even"> 
   </cfif>
   
   <cfif x is day(attributes.date) AND month(attributes.date) eq month(now())>
      <cfset class="today#class#"/>
   </cfif>
   
<cfsavecontent variable="cellContent"> 
   <div class="date">#x#</div>
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
   
</cfsavecontent>
    
   <cfset counter = counter + 1>
   
   <cfif counter is 8>
      <cfset class = "last #class# "/>
      <cfset spanner = 2 />
    
      <cfif x lt days>
         <cfset counter = 1>
      </cfif>
    
    <cfelseif counter eq 2>
        <cfset spanner = 2 />
    </cfif>
    
<div class="column span-#spanner# #class# cell">
    #cellContent#
</div>
   <cfset class=""> 
</cfloop>

<cfif counter is not 8>
   <cfset endPad = (8 - counter) * 3>
<div class="column span-#endPad# last cell">
  &nbsp;
</div>
</cfif>
</cfoutput>
