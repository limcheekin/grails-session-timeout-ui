# Grails Timeout Plugin - Warns User for Session Timeout

## Overview
The plugin enabled the web application prompts a message box prior to session timeout.

## Message Boxes Supported
### Web Browser Message Box
If you only need basic standard message box like the following image, you can run the plugin without dependency to [jQuery](http://www.grails.org/plugin/jquery) and [jQuery UI](http://www.grails.org/plugin/jquery-ui) plugin.
![alt text](https://raw.github.com/limcheekin/grails-timeout/master/docs/images/standard.jpg "Web Browser Message Box")

### jQuery UI Message Box
If you need jQuery UI style of message box like the following images, your Grails project need to install jQuery and jQuery UI plugin.
| Standard | Custom | 
| -------- | ------ |
| ![alt text](https://raw.github.com/limcheekin/grails-timeout/master/docs/images/jqueryUI.jpg "Standard jQuery UI Message Box")
 | ![alt text](https://raw.github.com/limcheekin/grails-timeout/master/docs/images/jqueryUI-custom.jpg "Custom jQuery UI Message Box") |

## Installation
The preferred method for installing plugins is to add a plugins dependency in `grails-app/conf/BuildConfig.groovy`, i.e.:
```groovy
plugins {
    // Other plugin dependencies here
    // . . .
    // . . .

	runtime ':timeout:latest.version' 
}
```

## Configuration
You need the add the following line of configuration to `grails-app/conf/Config.groovy` file, otherwise the plugin will cease to start:
```groovy
timeout.maxInactiveInterval = n * 60 // in seconds
```
You are right! The configuration above is to define interval of session timeout which equivalents to `session.maxInactiveInterval`, you need to configure it simply because I am unable to make `session.maxInactiveInterval` work with [GSP Resources](http://grails.org/plugin/gsp-resources) plugin. The value of `session.maxInactiveInterval` always equals to `0` in gsp resources. If you know the solution, I'm very appreciate if you could share it [here](https://github.com/limcheekin/grails-timeout/issues). 

`n` is the value you specified in the following configuration of the `web.xml` file:
```xml
<session-config>
	<session-timeout>n</session-timeout>
</session-config>
```

Other configurations with default value:
```groovy
timeout.currentTimePlaceholder = "[[[currentTimePlaceholder]]]" // to be replaced by local time of the browser
timeout.alertOnSecondsBeforeTimeout = 30 // prompt message box n seconds before session time out
timeout.logoutUrl = '../logout' // redirect to this URL when user press Cancel button
timeout.redirectUrl = '' // redirect to this URL when user press OK button, when it is empty redirect to current URL
timeout.redirectUponTimeout = true // auto redirect to the redirectUrl upon timeout, you should see login screen as session expired
timeout.hasJQueryUi = false // set to true to support JQuery UI message box even jquery-ui plugin is not installed
```

## Usage
### Web Browser Message Box
Add timeout module to your GSP:
```xml
<r:require module="timeout" />
```
That's all, no coding required.

### jQuery UI Message Box
Add timeout module to your GSP:
```xml
<r:require modules="jquery, jquery-ui, timeout" />
```
Make sure you install jQuery UI plugin by add it to plugins dependency in `grails-app/conf/BuildConfig.groovy`, i.e.:
```groovy
plugins {
    // Other plugin dependencies here
    // . . .
    // . . .

	runtime ':jquery-ui:latest.version' 
}
```
## Internationalization
You can change the default text of the message box in `grails-app/i18n/messages.properties` file. For example, the following are text of Custom jQuery UI Message Box:
```groovy
timeout.title=WARNING
timeout.message=Your session will expire in <span id="timeoutCounter"></span> seconds.
timeout.ok.button.label=Continue
timeout.cancel.button.label=Logout
```

## Sample Application
Kindly check out the [timeout-demo](http://github.com/limcheekin/timeout-demo) application on how I use the plugin with [Spring Security Core](http://grails.org/plugin/spring-security-core) plugin.

## Version History
###1.0 dd-MMM-yyyy###
* Initial implementation with browsers' standard message box and JQuery UI message box support.