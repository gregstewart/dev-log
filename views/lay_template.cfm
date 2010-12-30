<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>DevLog</title>

<script language="javascript" type="text/javascript" src="views/js/prototype.js"></script>
<!-- Framework CSS -->
	<link rel="stylesheet" href="views/css/blueprint/screen.css" type="text/css" media="screen, projection">
	<link rel="stylesheet" href="views/css/blueprint/print.css" type="text/css" media="print">
	<!--[if IE]><link rel="stylesheet" href="views/css/blueprint/lib/ie.css" type="text/css" media="screen, projection"><![endif]-->
	<!-- Show the grid and baseline -->
	<style type="text/css">
	/*<![CDATA[*/
		body {
			background: #fff url('views/images/body_back.gif') repeat-x;
		}
		
		.container { 
			background: url('views/css/blueprint/lib/grid.png');
		} 
        
        .page-title { margin-top : 30px; }
        
        .nav { margin : 10px 0; }
        select { border:1px solid #ccc; background:#f6f6f6; width: auto; }
    /*]]>*/
	</style>
    <link rel="stylesheet" href="views/css/footer.css" type="text/css" media="screen">
</head>
<body>
<cfoutput>
	<div class="container">
        <div class="column span-24 last page-title">
			<h1>DevLog</h1>
		</div>
        <div class="column span-24 last nav">
			<cfif session.user.getIsLoggedIn()> <a href="#variables.mySelf##xfa.processLogout#" title="logout">Logout</a> | <a href="#variables.mySelf##xfa.calendarView#" title="calendar">Calendar</a> | <a href="#variables.mySelf##xfa.homeView#" title="home">Home</a> </cfif>
		</div>
    	<div class="#pageCss#">
	    #body#
        </div>
        <div class="column span-24 footer">
			<div class="column prepend-1 span-4">
				<p>TCIAS &copy;#year(now())#</p>
			</div>
			<div class="column span-16 pull-1">
				<p class="center">Powered by Fusebox 5! (build <cfoutput>#myFusebox.getApplication().getVersion()# - #myFusebox.getApplication().mode#</cfoutput>)</p>
			</div>
			<div class="column span-4 pull-1 append-1 last">
				<p></p>
			</div>
		</div>
    </div>
</cfoutput>
</body>
</html>