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
    
    <h2>Sign up</h2>
    
	<form id="frm_signup" name="frm_signup" method="post" action="#variables.mySelf##xfa.doSignup#">
        <label for="firstName">First Name <span>*</span>:</label><input type="text" id="firstName" name="firstName" value=""/><br />
        <label for="lastName">Last Name <span>*</span>:</label><input type="text" id="lastName" name="lastName" value=""/><br />
        <label for="email">Email <span>*</span>:</label><input type="text" id="email" name="email" value=""/><br />
        <label for="username">Username <span>*</span>:</label><input type="text" id="username" name="username" value=""/><br />
        <label for="password">Password <span>*</span>:</label><input type="password" id="password" name="password" value=""/><br />
        <input type="submit" id="submit" value="Sign up"/>
    </form>
    
    <p>We will never share your e-mail address with anyone, period.</p>
    
    <p><a href="#variables.mySelf##xfa.back#" title="Back">Back</a></p>
</cfoutput>