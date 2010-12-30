<cfoutput>
<form action="#variables.myself##xfa.addClient#" method="post" name="addClientForm" id="addClientForm" enctype="application/x-www-form-urlencoded">
    <label for="name">Name</label><input type="text" id="name" name="name" value="#variables.client.getName()#"/><br />
    <input type="submit" name="submit" id="submit" value="Submit"/>
    <input type="hidden" name="client_id" id="client_id" value="#variables.client.getId()#"/>
    <input type="hidden" name="add_client" id="add_client" value="add_client"/>
</form>
<a href="#variables.myself##xfa.backToLog#">Back</a>
</cfoutput>