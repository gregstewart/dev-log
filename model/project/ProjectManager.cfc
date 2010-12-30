<cfcomponent displayname="Project Manager" hint="I manage projects" output="false">
    <!--- Author: gregstewart - Date: 5/22/2007 --->
	<cffunction name="init" output="false" access="public" returntype="ProjectManager" hint="I initialise the component">
	    <cfargument name="transfer" type="WEB-INF.cftags.component" required="true" />
        
        <cfset variables.transfer = arguments.transfer/>
        
        <cfreturn this/>
    </cffunction>
    
    <!--- Author: gregstewart - Date: 6/1/2007 --->
	<cffunction name="getProjects" output="false" access="public" returntype="query" hint="I return all projects for a given user or client">
	    <cfargument name="userId" type="numeric" required="true" />
        <cfargument name="clientId" type="numeric" required="true" />
        
        <cfscript>
            //create a query object
			var query = variables.transfer.createQuery("select Project.name as ProjectName, Project.Id From project.Project as Project join client.ClientProjectRel as c2p on c2p.project_id = Project.id join user.ProjectUserRel as u2p on u2p.project_id = Project.id	Where	u2p.user_id = :idUser And c2p.client_id = :idClient");
			//set the named parameter
			query.setParam("idUser", arguments.userId, "numeric");
			query.setParam("idClient", arguments.clientId, "numeric");
			//run it
			return variables.transfer.listByQuery(query);
		</cfscript>
        
    </cffunction>
    
    <!--- Author: gregstewart - Date: 6/4/2007 --->
	<cffunction name="set" output="false" access="public" returntype="WEB-INF.cftags.component" hint="I create/update a project">
	    <cfargument name="userId" type="numeric" required="true" />
	    <cfargument name="formValues" type="Struct" required="true" />
                    
        <cfset var project = ""/>
        <cfset var user = ""/>
        <cfset var client = ""/>
        
        <cftry>
	        <cfif arguments.formValues.project_id eq 0>
	            <cfset project = variables.transfer.new("project.Project")/>
	            <cfset project.setName(arguments.formValues.name)/>
	            <cfset project.setDescription(arguments.formValues.description)/>
	            <cfset project.setDateAdded(now())/>
	            <cfset project.setDateUpdated(now())/>
	        <cfelse>
                <cfset project = variables.transfer.get("project.Project",arguments.formValues.project_id)/>
	            <cfset project.setName(arguments.formValues.name)/>
	            <cfset project.setDescription(arguments.formValues.description)/>
	            <cfset project.setDateUpdated(now())/>
	        </cfif>

            <cfset client = variables.transfer.get("client.Client", arguments.formValues.client_Id)/>
			<cfset user = variables.transfer.get("user.User", arguments.userId)/>
            <cfset project.addClientProjectRel(client)/>
            <cfset project.addUserProjectRel(user)/>
            <cfset variables.transfer.save(project)/>
            
            <cfcatch type="any">
                <cfdump var="#cfcatch#"/><cfabort />
            </cfcatch>
        </cftry>
        
        <cfreturn project/>
	</cffunction>
    
    <!--- Author: gregstewart - Date: 6/4/2007 --->
	<cffunction name="get" output="false" access="public" returntype="WEB-INF.cftags.component" hint="">
	    <cfargument name="projectId" type="numeric" required="true" />
	    
	    <cfif arguments.projectId eq 0>
	        <cfreturn variables.transfer.new("project.Project")/>
	    <cfelse>
	        <cfreturn variables.transfer.get("project.Project",arguments.projectID)/>
	    </cfif>
	</cffunction>
</cfcomponent>