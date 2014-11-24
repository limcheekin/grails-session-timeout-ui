# Grails Session Timeout UI Plugin

## Overview
The plugin enabled the web application prompts a message box prior to session timeout.

## Message Boxes Supported
### Web Browser Message Box
If you only need basic standard message box like the following image, you can run the plugin without dependency to [jQuery](http://www.grails.org/plugin/jquery) and [jQuery UI](http://www.grails.org/plugin/jquery-ui) plugin.

![alt text](https://raw.github.com/limcheekin/grails-session-timeout-ui/master/docs/images/standard.jpg "Web Browser Message Box")

### jQuery UI Message Box
If you need jQuery UI style of message box like the following images, your Grails project need to install jQuery and jQuery UI plugin.

#### Standard
![alt text](https://raw.github.com/limcheekin/grails-session-timeout-ui/master/docs/images/jqueryUI.jpg "Standard jQuery UI Message Box")

#### Custom
![alt text](https://raw.github.com/limcheekin/grails-session-timeout-ui/master/docs/images/jqueryUI-custom.jpg "Custom jQuery UI Message Box")

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
session.timeout.ui.maxInactiveInterval = n * 60 // in seconds
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
session.timeout.ui.currentTimePlaceholder = "[[[currentTimePlaceholder]]]" // to be replaced by local time of the browser
session.timeout.ui.alertOnSecondsBeforeTimeout = 30 // prompt message box n seconds before session time out
session.timeout.ui.logoutUrl = '../logout' // redirect to this URL when user press Cancel button
session.timeout.ui.redirectUrl = '' // redirect to this URL when user press OK button, when it is empty redirect to current URL
session.timeout.ui.redirectUponTimeout = true // auto redirect to the redirectUrl upon timeout, you should see login screen as session expired
session.timeout.ui.hasJQueryUi = false // set to true to support JQuery UI message box even jquery-ui plugin is not installed
session.timeout.ui.resetCounterOnClick = false // set to true to reset the timeout counter to 0 on mouse click
session.timeout.ui.resetCounterOnKeyPress = false // set to true to reset the timeout counter to 0 on key press
```

## Usage
### Web Browser Message Box
Add timeout module to your GSP:
```xml
<r:require module="session-timeout-ui" />
```
That's all, no coding required.

### jQuery UI Message Box
Add jquery, jquery-ui and timeout modules to your GSP:
```xml
<r:require modules="jquery, jquery-ui, session-timeout-ui" />
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
session.timeout.ui.title=WARNING
session.timeout.ui.message=Your session will expire in <span id="timeoutCounter"></span> seconds.
session.timeout.ui.ok.button.label=Continue
session.timeout.ui.cancel.button.label=Logout
```

## Sample Application
Kindly check out the [session-timeout-ui-demo](http://github.com/limcheekin/grails-session-timeout-ui-demo) application on how I use the plugin with [Spring Security Core](http://grails.org/plugin/spring-security-core) plugin.

## Version History
###1.0 dd-MMM-yyyy###
* Initial implementation with browsers' standard message box and JQuery UI message box support.