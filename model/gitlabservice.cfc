<cfcomponent displayname="gitLabService" output="false" singleton>

	<cffunction name="init" returntype="any" output="false">
		<cfreturn this />
	</cffunction>

	<cffunction name="getProjects" returntype="any" output="false" hint="I return an array of groups and projects from GitLab.">
		<cfargument name="apiKey" required="true">
		<cfargument name="gitLabURL" required="true">

		<cfset var projectArray = []>
		<cfset var page = "">
		<cfset var gitProjects = "">

		<cfloop from="1" to="2" index="page">
			<cfhttp url="#arguments.gitLabURL#/api/v3/projects" result="gitProjects">
			  <cfhttpparam type="url" name="private_token" value="#arguments.apiKey#">
			  <cfhttpparam type="url" name="per_page" value="100">
			  <cfhttpparam type="url" name="page" value="#page#">
			</cfhttp>
			<cfset projectArray = ArrayMerge(projectArray, DeserializeJSON(gitProjects.fileContent))>
		</cfloop>

		<cfreturn projectArray />
	</cffunction>

	<cffunction name="setProjectsToStruct" returntype="any" output="false" hint="I return a struct of groups and related projects.">
		<cfargument name="projects" required="true">

		<cfset var groupStruct = {}>
		<cfset var node = "">
		<cfset var group = "">
		<cfset var project = "">

		<cfloop array="#arguments.projects#" item="node">
			<cfset group = node.namespace.name>
			<cfset project = node.name>
			<cfif NOT structKeyExists(groupStruct,"#group#")>
			 	<cfset groupStruct[group] = []>
			 	<cfset groupStruct[group][arrayLen(groupStruct[group])+1] = project>
			<cfelse>
				<cfset groupStruct[group][arrayLen(groupStruct[group])+1] = project>
			</cfif>
		</cfloop>

		<cfreturn groupStruct />
	</cffunction>

	<cffunction name="createPropertyList" returntype="any" output="false" hint="I return a formatted property list.">
		<cfargument name="projectList" required="true">
		<cfargument name="apiKey" required="true">
		<cfargument name="gitLabURL" required="true">

		<cfset var br = chr(13) & chr(10) />
		<cfset var propertyText = "">
		<cfset var group = "">
		<cfset var projectArray = "">
		<cfset var i = "">
		<cfset var project = "">
		<cfset var branchStruct = "">
		<cfset var branch = "">

<!--- be careful of whitespace below!  You can also tweak whitespace settings in Lucee --->
		<cfsavecontent variable="propertyText">
		<cfsetting  enableCFoutputOnly = "yes">
			<cfloop collection="#arguments.projectList#" index="group" item="projectArray">

				<cfoutput>[#group#]#br#</cfoutput>
				<cfloop array="#projectArray#" index="i" item="project">

					<cfhttp url="#arguments.gitlabURL#/api/v3/projects/#lcase(group)#%2F#lcase(project)#/repository/branches" result="branchStruct">
						<cfhttpparam type="url" name="private_token" value="#arguments.apiKey#">
					</cfhttp>

					<cfif IsJson(branchStruct.fileContent)>
						<cfset branchStruct = DeserializeJSON( branchStruct.fileContent )>
						<cfif IsArray(branchStruct) AND ArrayLen(branchStruct)>
							<cfoutput>#project#=<cfloop array="#branchStruct#" index="i" item="branch"><cfif i NEQ 1>,</cfif>#branch.name#</cfloop>#br#</cfoutput>
						</cfif>
					</cfif>

				</cfloop>
			</cfloop>
			<cfoutput>Generated #now()#</cfoutput>
			<cfsetting  enableCFoutputOnly = "No">
		</cfsavecontent>

		<cfreturn propertyText />
	</cffunction>

</cfcomponent>