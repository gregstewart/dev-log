<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE fusebox>
<!--
	Example fusebox.xml control file. Shows how to define circuits, classes,
	parameters and global fuseactions.
-->
<fusebox>
	<circuits>
		<circuit alias="m" path="model/" parent="" />
		<circuit alias="v" path="views/" parent="" />
		<circuit alias="app" path="controller/" parent="" />
        <circuit alias="login" path="controller/login/" parent="app" />
        <circuit alias="signup" path="controller/signup/" parent="app" />
	</circuits>

	<classes>
	</classes>

	<parameters>
		<parameter name="defaultFuseaction" value="app.main" />
		<!-- you may want to change this to development-full-load mode: -->
		<parameter name="mode" value="development-full-load" /><!-- production -->
		<!-- change this to something more secure: -->
		<parameter name="password" value="skeleton" />
		<!--
			These are all default values that can be overridden:
		<parameter name="fuseactionVariable" value="fuseaction" />
		<parameter name="precedenceFormOrUrl" value="form" />
		<parameter name="scriptFileDelimiter" value="cfm" />
		<parameter name="maskedFileDelimiters" value="htm,cfm,cfml,php,php4,asp,aspx" />
		<parameter name="characterEncoding" value="utf-8" />
		<paramater name="strictMode" value="false" />
		<parameter name="allowImplicitCircuits" value="false" />
		-->
        <parameter name="debug" value="false" />
	</parameters>

	<globalfuseactions>
		<appinit>
			<fuseaction action="app.initialize"/>
		</appinit>
		
        <!--
        <preprocess>
        </preprocess>
         
        <postprocess>
			<fuseaction action="m.postprocess"/>
		</postprocess>
		-->
	</globalfuseactions>

	<plugins>
		<phase name="preProcess">
			<!-- <plugin name="isLoggedIn" template="isLoggedIn"/> -->
		</phase>
		<phase name="preFuseaction">
		</phase>
		<phase name="postFuseaction">
		</phase>
		<phase name="fuseactionException">
		</phase>
		<phase name="postProcess">
		</phase>
		<phase name="processError">
		</phase>
	</plugins>

</fusebox>
