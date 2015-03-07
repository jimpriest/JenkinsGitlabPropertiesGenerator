<cfcomponent output="false"
	extends="coldbox.system.ioc.config.Binder"
	hint="The default WireBox Injector configuration object" >

	<cfscript>
		function configure(){
			wireBox = {
				scopeRegistration = {
					enabled = true,
					scope   = "application", // server, cluster, session, application
					key		= "wireBox"
				}
			};
			mapDirectory( getAppMapping() & ".model" );
		}
	</cfscript>
</cfcomponent>