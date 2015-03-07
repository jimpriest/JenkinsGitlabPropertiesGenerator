## Jenkins Gitlab Properties Generator
Code to generate a property list of projects/branches for Jenkins from Gitlab. 

### Purpose
This code will generate a .properties file which can be read by the Extended Choice Parameter Script plugin in Jenkins.  I use this to allow our QA person to easily deploy git features branches to our QA server.

### Requirements
* [Gitlab](https://about.gitlab.com/features/#community) VCS server
* [Lucee](http://lucee.org/) application server
* [Jenkins](http://jenkins-ci.org/) CI server
* [Extended Choice Parameter Script plugin](https://wiki.jenkins-ci.org/display/JENKINS/Extended+Choice+Parameter+Script+plugin)
* Some shared drive space / SSH, etc.

### Install
* Downlod the Jenkins Gitlab Properties Generator (JGPG) code.
* Download the latest [ColdBox 4.x](http://www.coldbox.org/download) standalone, unzip and drop the ColdBox file in the root of the JGPG folder.

This assumes you have a working Lucee/Railo installation. If you don't, the quickest way to get this up an running is via [CommandBox](https://www.ortussolutions.com/products/commandbox). Follow the installation instructions for CommandBox, download the JGPG code, open a command prompt in the JGPG directory and type 'box server start'.  

This will start a server - note the port # in the prompt: 127.0.0.1:58374. 

Open this URL in your browser.  http://127.0.0.1:commandboxport

### Configuration
* Open /jgpg/confi/Coldbox.cfc and enter in your Gitlab URL,  API key and the path to where you want your property file stored. Note the property file location needs to be readable from your Jenkins server!

  ```
  settings = {
  apiKey = 'enter-your-key-here',
  propertyPath = 'enter-path-to-where-you-want-properties-file',
  gitlaburl = 'enter-the-root-url-to-your-gitlab-instance'
  }
  ```
  
### Usage
Setup a scheduled task to run this code and generate a new .properties file as needed. I run this once a day. We don't create feature branches that often and I find this is an acceptable schedule. YMMV.

See my [blog about details on how to setup Jenkins using the Extended Choice Parameter Script]().

### Notes
This code is really overly complicated for what it does. This was just an excuse for me to try out writing something quick in ColdBox hence my use of views, etc., which in this case are really unnecessary.  If I have time I would actually like to re-write this to use CommandBox.
