<%--
* Copyright 2013 the original author or authors.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*      http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*
* @author <a href='mailto:limcheekin@vobject.com'>Lim Chee Kin</a>
*
* @since 1.0

References:
===========
http://stackoverflow.com/questions/13246378/detecting-user-inactivity-over-a-browser-purely-through-javascript
http://stackoverflow.com/questions/17776940/javascript-module-pattern-with-example
--%>
<% 
if (!grailsApplication.config.session.timeout.ui.maxInactiveInterval) {
    throw new RuntimeException('session.timeout.ui.maxInactiveInterval is not configured! Please configure it in Config.groovy file.')
}
%>
<g:set var="hasJQueryUiPlugin" value="${grailsApplication.mainContext.pluginManager.hasGrailsPlugin('jquery-ui')}" />
<g:set var="CURRENT_TIME_PLACEHOLDER" value="${grailsApplication.config.session.timeout.ui.currentTimePlaceholder?:'[[[currentTimePlaceholder]]]'}" />
<g:set var="ALERT_ON_SECONDS_BEFORE_TIMEOUT" value="${grailsApplication.config.session.timeout.ui.alertOnSecondsBeforeTimeout?:30}" />

var grailsTimeout = (function (grailsTimeout) {
	var IDLE_TIMEOUT_IN_SECONDS = ${grailsApplication.config.session.timeout.ui.maxInactiveInterval}; 
	var ALERT_ON_SECONDS_BEFORE_TIMEOUT = ${ALERT_ON_SECONDS_BEFORE_TIMEOUT};
	var ALERT_ON_COUNTER = IDLE_TIMEOUT_IN_SECONDS - ALERT_ON_SECONDS_BEFORE_TIMEOUT;
	var REDIRECT_UPON_TIMEOUT = ${grailsApplication.config.session.timeout.ui.get("redirectUponTimeout", true)};
	var REDIRECT_URL = "${grailsApplication.config.session.timeout.ui.redirectUrl?:''}";
	var LOGOUT_URL = "${grailsApplication.config.session.timeout.ui.logoutUrl?:'../logout'}";
	var _idleSecondsCounter = 0;

	var title = "${message(code: 'session.timeout.ui.title', default: 'WARNING')}";
	var messageTemplate = "${message(code: 'session.timeout.ui.message', default: "Your session will expire in ${ALERT_ON_SECONDS_BEFORE_TIMEOUT} seconds starting from ${CURRENT_TIME_PLACEHOLDER}.\n\nPress OK to continue, or Cancel to logout.", args:[ALERT_ON_SECONDS_BEFORE_TIMEOUT, CURRENT_TIME_PLACEHOLDER]).encodeAsJavaScript()}";
	var okButtonLabel = "${message(code: 'session.timeout.ui.ok.button.label', default: 'OK')}";
	var cancelButtonLabel = "${message(code: 'session.timeout.ui.cancel.button.label', default: 'Cancel')}";
    var message;

    <g:if test="${grailsApplication.config.session.timeout.ui.resetCounterOnClick}">
	document.onclick = function() {
    	_idleSecondsCounter = 0;
	};
    </g:if>

    <g:if test="${grailsApplication.config.session.timeout.ui.resetCounterOnKeyPress}">
	document.onkeypress = function() {
    	_idleSecondsCounter = 0;
	};
    </g:if>
	
	window.setInterval(checkIdleTime, 1000);

	function checkIdleTime() {
    	_idleSecondsCounter++;

    	if (_idleSecondsCounter===ALERT_ON_COUNTER) {
    		message = messageTemplate.replace("${CURRENT_TIME_PLACEHOLDER}", getCurrentTimeInHHMMSSFormat());
    		window.focus();
        	grailsTimeout.showAlert();
    	}

        var timeoutCounter = document.getElementById("timeoutCounter");
        if (timeoutCounter) {
            var counter = IDLE_TIMEOUT_IN_SECONDS - _idleSecondsCounter;
            if (counter >= 0) timeoutCounter.innerHTML = counter + "";
        }

    	if (_idleSecondsCounter===IDLE_TIMEOUT_IN_SECONDS && REDIRECT_UPON_TIMEOUT) {
    		timeout();
    	}
    }

	function getCurrentTimeInHHMMSSFormat() {
    	var date = new Date(); 
		var hh = date.getHours(); 
		var mm = date.getMinutes(); 
		var ss = date.getSeconds(); 

		if (hh < 10) { hh = "0" + hh; }
    	if (mm < 10) { mm = "0" + mm; }
    	if (ss < 10) { ss = "0" + ss; }

    	return hh + ":" + mm + ":" + ss;
	}

	function redirect() {
        if (REDIRECT_URL != '') {
            sendAjaxRequest(REDIRECT_URL);
        } else {
            sendAjaxRequest(window.location.pathname);
        }		
	}

    function timeout() {
        if (REDIRECT_URL != '') {
            window.location = REDIRECT_URL;
        } else {
            window.location = window.location.pathname;
        }       
    }    

	function logout() {
		window.location = LOGOUT_URL; 
	}

    function sendAjaxRequest(url) {
        //alert ('sendAjaxRequest');
        _idleSecondsCounter = 0;
        var ajaxRequest;  // The variable that makes Ajax possible!
        
        try{
            // Opera 8.0+, Firefox, Safari
            ajaxRequest = new XMLHttpRequest();
        } catch (e){
            // Internet Explorer Browsers
            try{
                ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
            } catch (e) {
                try{
                    ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
                } catch (e) {
                    // Something went wrong
                    alert("Your browser doesn't support AJAX!");
                    return false;
                }
            }
        }
        // Create a function that will receive data sent from the server
        ajaxRequest.onreadystatechange = function() {
            if(ajaxRequest.readyState == 4) { // The request is complete
                // alert("response status = " + ajaxRequest.status);
                // alert(ajaxRequest.responseText);
                // refresh the screen if AJAX request failed
                if (ajaxRequest.status != 200) 
                    window.location = url;
            }
        }

        url = addTimestampToURL(url);
        ajaxRequest.open("GET", url, true);
        ajaxRequest.send(); 
    } 

    // For IE 8
    function addTimestampToURL(url) {
        var currentTime = new Date().getTime();
        if (url.lastIndexOf("?") > -1) {
            url += "&" + currentTime;
        } else {
            url += "?" + currentTime;
        }
        return url; 
    }   	
<g:if test="${hasJQueryUiPlugin || grailsApplication.config.session.timeout.ui.hasJQueryUi}">
    $(document).ajaxSend(function() { // reset counter for any ajax request
        _idleSecondsCounter = 0;
    });

	function showJQueryUiAlert() {
        message = message.replace(/\r\n|\n/g, '<br />'); 
        var dialog = '<div class="timeoutDialog" title="' + title + '">' + '<p>' + message + '</p></div>';

        $(dialog).dialog({
            autoOpen: true,
            modal: true,
            resizable: false,
            buttons: [
                { text: okButtonLabel, click: function () { redirect(); $(this).dialog("close"); } },
                { text: cancelButtonLabel, click: function () { logout(); $(this).dialog("close"); } }
            ],
            close: function (event, ui) {
                var $this = $(this);
                $this.dialog("destroy");
                $this.remove();
            }
        });
	}

	grailsTimeout.showAlert = function () {
        showJQueryUiAlert();
    };	
</g:if>
<g:else>
	function showStandardAlert() {
		if (confirm(title + "\n\n" + message)) {
			redirect();
      	} else {
			logout();
        }
	}

	grailsTimeout.showAlert = function () {
        showStandardAlert();
    };	
</g:else>
    return grailsTimeout;
}(grailsTimeout || {}));	