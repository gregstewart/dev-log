<cfchart  xAxisTitle="Projects" yAxisTitle="Time" show3d="yes" chartheight="400" chartwidth="400">
   <cfchartseries type="pie" query="variables.summary" valueColumn="total_hours" itemColumn="title"/>
</cfchart>

<cfdump var="#variables.summary#"/>