component{
	// Configure ColdBox Application
	function configure(){

		coldbox = {
			//Application Setup
			appName = "JENKINSPROPERTYFILEGENERATOR",
			eventName  = "event",
			customErrorTemplate		= "/coldbox/system/includes/BugReport.cfm",
		};

		// application settings
		settings = {
			apiKey = 'enter-your-key-here',
			// apiKey = 'sOm35ecreTC0d3',
			propertyPath = 'enter-path-to-where-you-want-properties-file',
			// propertyPath = '/home/jim/temp/jenkins.prop',
			gitlaburl = 'enter-the-root-url-to-your-gitlab-instance'
			//gitLabURL = 'https://gitlab.com/'
		}

		// Debugger Settings
		debugger = {
			debugMode = false,
		};
	}
}