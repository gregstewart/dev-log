<cfchart  xAxisTitle="Projects" yAxisTitle="Time" show3d="yes" chartwidth="240">
   <cfchartseries type="pie" query="variables.summary" valueColumn="total_hours" itemColumn="title"/>
</cfchart>