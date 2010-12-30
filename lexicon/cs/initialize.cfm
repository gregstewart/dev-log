<cfscript>
	// Initializes ColdSpring into the current application scope (respecting the fusebox application key)
	// usage:
	// 1. add the lexicon declaration to your circuit file:
	//    <circuit xmlns:cs="coldspring/">
	// 2. use the verb in a fuseaction:
	//    <cs:initialize beanDefinitionFile="#expandPath('/config/ColdSpring.xml')#"/>
	//    <cs:initialize beanDefinitionFile="#expandPath('/config/ColdSpring.xml')#" coldspringfactory="servicefactory" defaultproperties="default coldspring properties"/>
	//
	if (fb_.verbInfo.executionMode is "start") {

		// coldspringfactory is optional:
		fb_.coldspringfactory = 'coldspring';
        if (structKeyExists(fb_.verbInfo.attributes,"coldspringfactory")) {
            fb_.coldspringfactory = '#fb_.verbInfo.attributes.coldspringfactory#';
        }

        // default properties is optional:
        fb_.defaultproperties = '##structnew()##';
        if (structKeyExists(fb_.verbInfo.attributes,"defaultproperties")) {
            fb_.defaultproperties = fb_.verbInfo.attributes.defaultproperties;
        }

		// beanDefinitionFile is required
		if (not structKeyExists(fb_.verbInfo.attributes,"beanDefinitionFile")) {
			fb_throw("fusebox.badGrammar.requiredAttributeMissing",
						"Required attribute is missing",
						"The attribute 'beanDefinitionFile' is required, for a 'initialize' verb in fuseaction #fb_.verbInfo.circuit#.#fb_.verbInfo.fuseaction#.");
		}
		//

		// set ColdSpring in this fusebox instance's application space
		fb_appendLine('<cfset myFusebox.getApplication().getApplicationData().#fb_.coldspringfactory# = createObject("component", "coldspring.beans.DefaultXmlBeanFactory").init( defaultProperties="#fb_.defaultproperties#" )/>');
		fb_appendLine('<cfset myFusebox.getApplication().getApplicationData().#fb_.coldspringfactory#.loadBeansFromXmlFile(beanDefinitionFile="#fb_.verbInfo.attributes.beanDefinitionFile#") />');

	} else {
		//
		// end mode - do nothing
	}
</cfscript>
