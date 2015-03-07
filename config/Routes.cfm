<cfscript>
	setUniqueURLS(false);
	if( len(getSetting('AppMapping') ) lte 1){
		setBaseURL("http://#cgi.HTTP_HOST#/index.cfm");
	}
	else{
		setBaseURL("http://#cgi.HTTP_HOST#/#getSetting('AppMapping')#/index.cfm");
	}

	addRoute(pattern=":handler/:action?");

	function PathInfoProvider(Event){
		return CGI.PATH_INFO;
	}
</cfscript>