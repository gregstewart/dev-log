<!--- <cfdump var="#variables.project.getClientProjectRelArray()#"/> --->
<cfoutput>
<form action="#variables.myself##xfa.addProject#" method="post" name="addProjectForm" id="addProjectForm" enctype="application/x-www-form-urlencoded">
    <label for="name">Name</label><input type="text" id="name" name="name" value="#variables.project.getName()#"/><br />
    <label for="client_id">Client</label>
    <select name="client_id" id="client_id">
        <cfloop from="1" to="#variables.clientArLen#" index="i">
        <option value="#variables.clientArray[i].getClientDetails().getId()#"<cfif attributes.client_id eq variables.clientArray[i].getClientDetails().getId()> selected="true"</cfif>>#variables.clientArray[i].getClientDetails().getName()#</option>
        </cfloop>
    </select><br />
    <label for="Description">Description</label><br /><textarea name="description" id="description" cols="25" rows="10">#variables.project.getDescription()#</textarea><br />
    <input type="submit" name="submit" id="submit" value="Submit"/>
    <input type="hidden" name="project_id" id="project_id" value="#variables.project.getId()#">
    <input type="hidden" name="add_project" id="add_project" value="add_project"/>
</form>
<a href="#variables.myself##xfa.backToLog#">Back</a>
</cfoutput>