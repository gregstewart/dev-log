<cfcomponent output="false">
	<!--- 
		public var username : String;
		public var password : String;
		public var loginDate : Date;
		public var isLoggedIn : Boolean;
	 --->
	<cfproperty name="username" type="string" default="">
	<cfproperty name="password" type="string" default="">
	<cfproperty name="loginDate" type="date" default="">
	<cfproperty name="isLoggedIn" type="isLoggedIn" default="">
	
	<!--- Initialize vars --->
	<cfscript>
		this.username="";
		this.password="";
		this.loginDate=now();
		this.isLoggedIn=false;
	</cfscript>
	
	
</cfcomponent>