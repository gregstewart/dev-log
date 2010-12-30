<cfoutput>
    <cfset variables.userErrors = session.user.getErrors()/>
    <cfif ArrayLen(variables.userErrors) neq 0>
        <p>The following error(s) were encountered:</p>
        <ul>
            <cfloop from="1" to="#ArrayLen(variables.userErrors)#" index="i">
            <li>#variables.userErrors[i]#</li>
            </cfloop>
        </ul>
        
    </cfif>
    
	<form id="frm_login" name="frm_login" method="post" action="#variables.mySelf##xfa.processLogin#">
        <label for="username">Username:</label><input type="text" id="username" name="username" value=""/><br />
        <label for="password">Password:</label><input type="password" id="password" name="password" value=""/><br />
        <input type="submit" id="submit" value="login"/>
    </form>
    <p><a href="#variables.mySelf##xfa.forgottenPassword#" title="Have you forgotten your password">Password forgotten?</a></p>
    <p><a href="#variables.mySelf##xfa.signUp#" title="Sign up here">Sign up!</a></p>
</cfoutput>