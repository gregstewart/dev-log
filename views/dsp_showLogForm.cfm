<script src="views/js/tiny_mce/tiny_mce.js"></script>
<script language="javascript" type="text/javascript">
	tinyMCE.init({
		mode : "textareas",
		theme : "advanced",
		plugins : "spellchecker,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,insertdatetime,preview,zoom,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,filemanager,imagemanager",
		theme_advanced_buttons1_add_before : "save,newdocument,separator",
		theme_advanced_buttons1_add : "fontselect,fontsizeselect",
		theme_advanced_buttons2_add : "separator,insertdate,inserttime,preview,separator,forecolor,backcolor",
		theme_advanced_buttons2_add_before: "cut,copy,paste,pastetext,pasteword,separator,search,replace,separator",
		theme_advanced_buttons3_add_before : "tablecontrols,separator",
		theme_advanced_buttons3_add : "emotions,iespell,media,advhr,separator,print,separator,ltr,rtl,separator,fullscreen",
		theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,|,spellchecker,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,|,insertfile,insertimage",
		theme_advanced_toolbar_location : "top",
		theme_advanced_toolbar_align : "left",
		theme_advanced_path_location : "bottom",
		content_css : "/example_data/example_full.css",
	    plugin_insertdate_dateFormat : "%Y-%m-%d",
	    plugin_insertdate_timeFormat : "%H:%M:%S",
		extended_valid_elements : "hr[class|width|size|noshade],font[face|size|color|style],span[class|align|style],p[lang]",
		external_link_list_url : "example_data/example_link_list.js",
		external_image_list_url : "example_data/example_image_list.js",
		flash_external_list_url : "example_data/example_flash_list.js",
		template_external_list_url : "example_data/example_template_list.js",
		file_browser_callback : "mcFileManager.filebrowserCallBack",
		theme_advanced_resize_horizontal : false,
		theme_advanced_resizing : true,
		apply_source_formatting : true,
		spellchecker_languages : "+English=en,Danish=da,Dutch=nl,Finnish=fi,French=fr,German=de,Italian=it,Polish=pl,Portuguese=pt,Spanish=es,Swedish=sv",
		width : "100%",
		height : "400"
	});

</script>
<!-- /tinyMCE -->
<script>
    function getProjects(e) {
        alert($F('client'));
        window.location='?fuseaction=app.getProjects&clientId=' + $F('client');
        Event.stop(e);
    }
</script>

<cfif StructKeyExists(variables,"errors") AND NOT ArrayIsEmpty(variables.errors)>
    <ul>
    <cfloop from="1" to="#ArrayLen(variables.errors)#" index="i">
        <li><cfoutput>#variables.errors[i]#</cfoutput></li>
    </cfloop>
    </ul>
</cfif>

<cfoutput>
    <form id="logForm" method="post" enctype="application/x-www-form-urlencoded">
        <label for="client_id">Client</label>
        <select name="client_id" id="client_id">
        <cfif variables.clientArLen>
            <cfloop from="1" to="#variables.clientArLen#" index="i">
            <option value="#variables.clientArray[i].getClientDetails().getId()#"<cfif variables.logEntry.hasClient() AND variables.logEntry.getClient().getId() eq variables.clientArray[i].getClientDetails().getId()> selected="true"</cfif>>#variables.clientArray[i].getClientDetails().getName()#</option>
            </cfloop>
        <cfelse>
            <option value="0">No clients found</option>
        </cfif>
        </select><input type="submit" value="add client" id="add_client" name="add_client"/><input type="submit" value="load projects" id="load_projects" name="load_projects"/><br />
        <label for="project">Project</label>
        <select name="project_id" id="project_id">
            <cfif StructKeyExists(variables,"projects")>
                <cfif variables.projects.recordcount>
                    <cfloop query="variables.projects">
                    <option value="#id#"<cfif variables.logEntry.hasProject() AND variables.logEntry.getProject().getId() eq id> selected="true"</cfif>>#projectName#</option>
                    </cfloop>
                <cfelse>
                    <option value="0">No projects found</option>
                </cfif>
            <cfelse>
                <option value="0">Please select a client first</option>
            </cfif>
        </select><input type="submit" value="add project" id="add_project" name="add_project"/><br />
        <label for="date">Date:</label><input type="text" name="date" id="date" value="#DateFormat(variables.logEntry.getLogDate(),"yyyy/mm/dd")#"/> <label for="to_date">to:</label> <input type="text" name="to_date" id="to_date" value=""/><br />
        <label for="hours">Hours:</label><input type="text" name="hours" id="hours" value="#variables.logEntry.getHours()#"/><br />
        <label for="details">Details:</label><br />
        <textarea name="details" id="details" cols="45" rows="10">#variables.logEntry.getDescription()#</textarea><br />
        <input type="submit" name="submit" id="submit" value="Submit"/>
        <input type="hidden" name="log_id" id="log_id" value="#variables.logEntry.getLog_Id()#"/>
    </form>
</cfoutput>
<script>
    //Event.observe('client','change',getProjects,false)
</script>